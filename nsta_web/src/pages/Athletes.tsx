import { useState, useMemo } from "react";
import { MainLayout } from "@/components/layout/main-layout";
import { Search, Filter, MoreHorizontal, User, MapPin, Trophy, Calendar, Plus, Edit, Trash2, Eye, Phone, Mail } from "lucide-react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog"
import { Label } from "@/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import { Checkbox } from "@/components/ui/checkbox"
import { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle, AlertDialogTrigger } from "@/components/ui/alert-dialog"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import { useAthletes, useStates, useSports } from "@/hooks/useFirebaseData"
import { useAthletesCRUD, validateAthlete } from "@/hooks/useFirebaseCRUD"
import { useAuth } from "@/hooks/useAuth"
import { Skeleton } from "@/components/ui/skeleton"
import { toast } from "sonner";
import AthleteForm from "@/components/forms/AthleteForm";

interface AthleteFormData {
  name: string;
  age: number;
  gender: 'Male' | 'Female' | '';
  state: string;
  district: string;
  phoneNumber: string;
  email: string;
  address: string;
  sportInterest: string[];
  medicalClearance: boolean;
  coachName: string;
  performance?: {
    verticalJump: number;
    sitUps: number;
    shuttleRun: number;
    flexibility: number;
    overallScore: number;
  };
}

export default function Athletes() {
  const { userRole, userData } = useAuth();
  
  // Apply role-based filtering
  const athleteFilters = userRole === 'academy' && userData?.academyId 
    ? { academyId: userData.academyId }
    : {};
  
  const { data: athletes, loading: athletesLoading, error: athletesError } = useAthletes(athleteFilters);
  const { data: states, loading: statesLoading } = useStates();
  const { data: sports } = useSports();
  const athletesCRUD = useAthletesCRUD();
  
  const [searchTerm, setSearchTerm] = useState('');
  const [stateFilter, setStateFilter] = useState('all');
  const [genderFilter, setGenderFilter] = useState('all');
  const [showAddDialog, setShowAddDialog] = useState(false);
  const [editingAthlete, setEditingAthlete] = useState<any>(null);
  const [selectedAthletes, setSelectedAthletes] = useState<string[]>([]);
  
  const [formData, setFormData] = useState<AthleteFormData>({
    name: '',
    age: 14,
    gender: '',
    state: '',
    district: '',
    phoneNumber: '',
    email: '',
    address: '',
    sportInterest: [],
    medicalClearance: false,
    coachName: ''
  });
  
  // Filter and search logic
  const filteredAthletes = useMemo(() => {
    if (!athletes) return [];
    
    return athletes.filter(athlete => {
      const matchesSearch = !searchTerm || 
        athlete.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        athlete.state.toLowerCase().includes(searchTerm.toLowerCase()) ||
        (athlete.sportInterest || []).some((sport: string) => 
          sport.toLowerCase().includes(searchTerm.toLowerCase())
        );
      
      const matchesState = stateFilter === 'all' || 
        athlete.state.toLowerCase() === stateFilter.toLowerCase();
      
      const matchesGender = genderFilter === 'all' || 
        athlete.gender.toLowerCase() === genderFilter.toLowerCase();
      
      return matchesSearch && matchesState && matchesGender;
    });
  }, [athletes, searchTerm, stateFilter, genderFilter]);
  
  const resetForm = () => {
    setFormData({
      name: '',
      age: 14,
      gender: '',
      state: '',
      district: '',
      phoneNumber: '',
      email: '',
      address: '',
      sportInterest: [],
      medicalClearance: false,
      coachName: ''
    });
  };
  
  const handleAddAthlete = async () => {
    const validation = validateAthlete(formData);
    
    if (!validation.isValid) {
      toast.error(`Please fix the following errors: ${validation.errors.join(', ')}`);
      return;
    }
    
    // Generate performance data
    const performance = {
      verticalJump: Math.floor(Math.random() * 30) + 40, // 40-70
      sitUps: Math.floor(Math.random() * 25) + 25, // 25-50
      shuttleRun: Math.round((Math.random() * 4 + 8.5) * 10) / 10, // 8.5-12.5
      flexibility: Math.floor(Math.random() * 15) + 10, // 10-25
      overallScore: 0
    };
    
    performance.overallScore = Math.min(100, Math.floor(
      (performance.verticalJump + performance.sitUps + (15 - performance.shuttleRun) * 4 + performance.flexibility) / 4 * 1.5
    ));
    
    const newAthlete = {
      ...formData,
      id: `ATH${Date.now()}`,
      registrationDate: new Date().toISOString().split('T')[0],
      lastAssessment: new Date().toISOString().split('T')[0],
      status: 'Active',
      performance,
      benchmarkStatus: performance.overallScore >= 80 ? 'Above' : performance.overallScore >= 70 ? 'At' : 'Below',
      // Add academy information for academy users
      ...(userRole === 'academy' && userData?.academyId && {
        academyId: userData.academyId,
        academyName: userData.academyName
      })
    };
    
    const success = await athletesCRUD.create(newAthlete);
    
    if (success) {
      toast.success('Athlete added successfully!');
      setShowAddDialog(false);
      resetForm();
    } else {
      toast.error('Failed to add athlete. Please try again.');
    }
  };
  
  const handleEditAthlete = (athlete: any) => {
    setEditingAthlete(athlete);
    setFormData({
      name: athlete.name,
      age: athlete.age,
      gender: athlete.gender,
      state: athlete.state,
      district: athlete.district,
      phoneNumber: athlete.phoneNumber,
      email: athlete.email || '',
      address: athlete.address || '',
      sportInterest: athlete.sportInterest || [],
      medicalClearance: athlete.medicalClearance || false,
      coachName: athlete.coachName || ''
    });
  };
  
  const handleUpdateAthlete = async () => {
    if (!editingAthlete) return;
    
    const validation = validateAthlete(formData);
    
    if (!validation.isValid) {
      toast.error(`Please fix the following errors: ${validation.errors.join(', ')}`);
      return;
    }
    
    const success = await athletesCRUD.update(editingAthlete.id, formData);
    
    if (success) {
      toast.success('Athlete updated successfully!');
      setEditingAthlete(null);
      resetForm();
    } else {
      toast.error('Failed to update athlete. Please try again.');
    }
  };
  
  const handleDeleteAthlete = async (athleteId: string, athleteName: string) => {
    const success = await athletesCRUD.delete(athleteId);
    
    if (success) {
      toast.success(`${athleteName} has been deleted successfully.`);
    } else {
      toast.error('Failed to delete athlete. Please try again.');
    }
  };
  
  const handleBulkDelete = async () => {
    if (selectedAthletes.length === 0) {
      toast.error('No athletes selected.');
      return;
    }
    
    const success = await athletesCRUD.bulkDelete(selectedAthletes);
    
    if (success) {
      toast.success(`${selectedAthletes.length} athletes deleted successfully.`);
      setSelectedAthletes([]);
    } else {
      toast.error('Failed to delete athletes. Please try again.');
    }
  };
  
  const handleSelectAthlete = (athleteId: string) => {
    setSelectedAthletes(prev => 
      prev.includes(athleteId) 
        ? prev.filter(id => id !== athleteId)
        : [...prev, athleteId]
    );
  };
  
  const handleSelectAll = () => {
    if (selectedAthletes.length === filteredAthletes.length) {
      setSelectedAthletes([]);
    } else {
      setSelectedAthletes(filteredAthletes.map(a => a.id));
    }
  };

  const getBenchmarkColor = (status: string) => {
    switch (status) {
      case 'Above':
        return 'bg-green-100 text-green-800'
      case 'At':
        return 'bg-yellow-100 text-yellow-800'
      default:
        return 'bg-red-100 text-red-800'
    }
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'Active':
        return 'bg-green-100 text-green-800'
      case 'Pending':
        return 'bg-yellow-100 text-yellow-800'
      default:
        return 'bg-red-100 text-red-800'
    }
  }

  return (
    <MainLayout 
      title="Athletes Management"
      description="Manage and track athlete profiles and performance"
    >
      <div className="space-y-6">
        <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
          <div>
            <h1 className="text-2xl font-bold text-foreground">
              {userRole === 'academy' ? 'My Academy Athletes' : 'Athletes Management'}
            </h1>
            <p className="text-muted-foreground">
              {userRole === 'academy' 
                ? `${userData?.academyName} • ${filteredAthletes.length} athletes`
                : `Manage and track athlete profiles and performance • ${filteredAthletes.length} athletes`
              }
            </p>
          </div>
          <div className="flex gap-2">
              {selectedAthletes.length > 0 && userRole === 'official' && (
                <AlertDialog>
                  <AlertDialogTrigger asChild>
                    <Button variant="destructive" size="sm">
                      <Trash2 className="mr-2 h-4 w-4" />
                      Delete Selected ({selectedAthletes.length})
                    </Button>
                  </AlertDialogTrigger>
                  <AlertDialogContent>
                    <AlertDialogHeader>
                      <AlertDialogTitle>Delete Athletes</AlertDialogTitle>
                      <AlertDialogDescription>
                        Are you sure you want to delete {selectedAthletes.length} selected athletes? This action cannot be undone.
                      </AlertDialogDescription>
                    </AlertDialogHeader>
                    <AlertDialogFooter>
                      <AlertDialogCancel>Cancel</AlertDialogCancel>
                      <AlertDialogAction onClick={handleBulkDelete} disabled={athletesCRUD.deleting}>
                        {athletesCRUD.deleting ? 'Deleting...' : 'Delete'}
                      </AlertDialogAction>
                    </AlertDialogFooter>
                  </AlertDialogContent>
                </AlertDialog>
              )}
            <Dialog open={showAddDialog} onOpenChange={setShowAddDialog}>
              <DialogTrigger asChild>
                <Button className="w-fit" onClick={resetForm}>
                  <Plus className="mr-2 h-4 w-4" />
                  Add New Athlete
                </Button>
              </DialogTrigger>
              <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
                <DialogHeader>
                  <DialogTitle>Add New Athlete</DialogTitle>
                  <DialogDescription>
                    {userRole === 'academy' 
                      ? `Add a new athlete to ${userData?.academyName}`
                      : 'Register a new athlete in the NSTA system.'
                    }
                  </DialogDescription>
                </DialogHeader>
                
                {/* Add Athlete Form */}
                <AthleteForm 
                  formData={formData}
                  setFormData={setFormData}
                  states={states}
                  sports={sports}
                />
                
                <DialogFooter>
                  <Button variant="outline" onClick={() => setShowAddDialog(false)}>
                    Cancel
                  </Button>
                  <Button onClick={handleAddAthlete} disabled={athletesCRUD.creating}>
                    {athletesCRUD.creating ? 'Adding...' : 'Add Athlete'}
                  </Button>
                </DialogFooter>
              </DialogContent>
            </Dialog>
          </div>
        </div>

      {/* Search and Filters */}
      <Card>
        <CardContent className="pt-6">
          <div className="flex flex-col gap-4 md:flex-row md:items-center">
            <div className="relative flex-1">
              <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
              <Input 
                placeholder="Search athletes by name, state, or sport..." 
                className="pl-10"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
            </div>
            <div className="flex gap-2">
              <Select value={stateFilter} onValueChange={setStateFilter}>
                <SelectTrigger className="w-[140px]">
                  <SelectValue placeholder="State" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All States</SelectItem>
                  {states?.map((state) => (
                    <SelectItem key={state.id} value={state.name}>
                      {state.name}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              <Select value={genderFilter} onValueChange={setGenderFilter}>
                <SelectTrigger className="w-[120px]">
                  <SelectValue placeholder="Gender" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All</SelectItem>
                  <SelectItem value="male">Male</SelectItem>
                  <SelectItem value="female">Female</SelectItem>
                </SelectContent>
              </Select>
              <div className="flex items-center gap-2">
                <Checkbox 
                  id="selectAll"
                  checked={selectedAthletes.length === filteredAthletes.length && filteredAthletes.length > 0}
                  onCheckedChange={handleSelectAll}
                />
                <Label htmlFor="selectAll" className="text-sm cursor-pointer">
                  Select All
                </Label>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Athletes Grid */}
      {athletesError && (
        <div className="text-center py-8 text-red-600">
          Error loading athletes: {athletesError.message}
        </div>
      )}
      
      {athletesLoading ? (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {Array.from({length: 6}).map((_, i) => (
            <div key={i} className="space-y-3">
              <Skeleton className="h-48 w-full" />
            </div>
          ))}
        </div>
      ) : (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {filteredAthletes?.map((athlete) => (
          <Card key={athlete.id} className={`transition-all hover:shadow-lg ${
            selectedAthletes.includes(athlete.id) ? 'ring-2 ring-blue-500 bg-blue-50' : ''
          }`}>
            <CardHeader className="pb-3">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <Checkbox 
                    checked={selectedAthletes.includes(athlete.id)}
                    onCheckedChange={() => handleSelectAthlete(athlete.id)}
                  />
                  <div className="h-10 w-10 rounded-full bg-primary/10 flex items-center justify-center">
                    <User className="h-5 w-5 text-primary" />
                  </div>
                  <div>
                    <CardTitle className="text-base">{athlete.name}</CardTitle>
                    <CardDescription className="text-sm">{athlete.age} years • {athlete.gender}</CardDescription>
                  </div>
                </div>
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" size="icon">
                      <MoreHorizontal className="h-4 w-4" />
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent align="end">
                    <DropdownMenuItem onClick={() => {}}>
                      <Eye className="mr-2 h-4 w-4" />
                      View Profile
                    </DropdownMenuItem>
                    <DropdownMenuItem onClick={() => handleEditAthlete(athlete)}>
                      <Edit className="mr-2 h-4 w-4" />
                      Edit Details
                    </DropdownMenuItem>
                    <DropdownMenuItem>
                      <Trophy className="mr-2 h-4 w-4" />
                      View Assessments
                    </DropdownMenuItem>
                    <DropdownMenuItem 
                      className="text-red-600"
                      onClick={() => handleDeleteAthlete(athlete.id, athlete.name)}
                    >
                      <Trash2 className="mr-2 h-4 w-4" />
                      Delete
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              </div>
            </CardHeader>
            
            <CardContent className="space-y-4">
              <div className="flex items-center gap-2 text-sm text-muted-foreground">
                <MapPin className="h-4 w-4" />
                <span>{athlete.district}, {athlete.state}</span>
              </div>

              <div className="flex flex-wrap gap-1">
                {(athlete.sportInterest || []).map((sport) => (
                  <Badge key={sport} variant="outline" className="text-xs">
                    {sport}
                  </Badge>
                ))}
              </div>

              <div className="space-y-2">
                <div className="flex justify-between text-sm">
                  <span className="text-muted-foreground">Overall Score</span>
                  <span className="font-semibold">{athlete.performance?.overallScore || 0}%</span>
                </div>
                <div className="w-full bg-secondary rounded-full h-2">
                  <div 
                    className="bg-primary rounded-full h-2 transition-all" 
                    style={{ width: `${athlete.performance?.overallScore || 0}%` }}
                  />
                </div>
              </div>

              <div className="flex items-center justify-between pt-2 border-t">
                <Badge className={getBenchmarkColor(athlete.benchmarkStatus)}>
                  {athlete.benchmarkStatus} Benchmark
                </Badge>
                <Badge className={`status-badge ${getStatusColor(athlete.status)}`}>
                  {athlete.status}
                </Badge>
              </div>

              <div className="flex items-center gap-2 text-xs text-muted-foreground">
                <Calendar className="h-3 w-3" />
                <span>Last assessment: {new Date(athlete.lastAssessment).toLocaleDateString()}</span>
              </div>
            </CardContent>
          </Card>
        )) || []}
        </div>
      )}

      {/* Edit Athlete Dialog */}
      <Dialog open={!!editingAthlete} onOpenChange={(open) => !open && setEditingAthlete(null)}>
        <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>Edit Athlete</DialogTitle>
            <DialogDescription>
              Update {editingAthlete?.name}'s information.
            </DialogDescription>
          </DialogHeader>
          
          <AthleteForm 
            formData={formData}
            setFormData={setFormData}
            states={states}
            sports={sports}
            isEditing
          />
          
          <DialogFooter>
            <Button variant="outline" onClick={() => setEditingAthlete(null)}>
              Cancel
            </Button>
            <Button onClick={handleUpdateAthlete} disabled={athletesCRUD.updating}>
              {athletesCRUD.updating ? 'Updating...' : 'Update Athlete'}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Pagination */}
      <div className="flex items-center justify-between">
        <p className="text-sm text-muted-foreground">
          Showing {filteredAthletes.length} of {athletes?.length || 0} athletes
          {searchTerm && ` (filtered by "${searchTerm}")`}
        </p>
        <div className="flex gap-2">
          <Button variant="outline" size="sm" disabled>
            Previous
          </Button>
          <Button variant="outline" size="sm" disabled>
            Next
          </Button>
        </div>
      </div>
      </div>
    </MainLayout>
  )
}