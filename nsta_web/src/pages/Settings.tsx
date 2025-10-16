import { useState } from "react";
import { useAuth } from "@/hooks/useAuth";
import { MainLayout } from "@/components/layout/main-layout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Textarea } from "@/components/ui/textarea";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { toast } from "sonner";
import { 
  User, 
  Shield, 
  Bell, 
  Globe, 
  Database, 
  Users, 
  Settings as SettingsIcon,
  Moon,
  Sun,
  Save,
  Edit3,
  Calendar,
  Mail,
  Phone,
  Weight,
  Ruler
} from "lucide-react";

export default function Settings() {
  const { user, userData, userRole } = useAuth();
  const [isEditing, setIsEditing] = useState(false);
  const [profileData, setProfileData] = useState({
    name: userData?.name || '',
    email: userData?.email || user?.email || '',
    phone: userData?.phone || '',
    sport: userData?.sport || '',
    userId: userData?.userId || user?.uid || '',
    height: userData?.height || '',
    weight: userData?.weight || '',
    role: userData?.role || userRole || ''
  });
  
  const handleSaveProfile = () => {
    // Here you would typically save to Firebase
    toast.success('Profile updated successfully!');
    setIsEditing(false);
  };
  
  const getInitials = (name: string) => {
    return name.split(' ').map(n => n[0]).join('').toUpperCase();
  };
  
  const formatRole = (role: string) => {
    return role.charAt(0).toUpperCase() + role.slice(1);
  };

  return (
    <MainLayout 
      title="Settings & Profile"
      description="Manage your profile and system preferences"
    >
      <div className="space-y-6">
        <Tabs defaultValue="profile" className="space-y-6">
          <TabsList className="grid w-full grid-cols-5">
            <TabsTrigger value="profile">Profile</TabsTrigger>
            <TabsTrigger value="users">Users</TabsTrigger>
            <TabsTrigger value="system">System</TabsTrigger>
            <TabsTrigger value="security">Security</TabsTrigger>
            <TabsTrigger value="notifications">Notifications</TabsTrigger>
          </TabsList>

          {/* Profile Settings */}
          <TabsContent value="profile" className="space-y-6">
            {/* Profile Header */}
            <Card className="bg-gradient-to-r from-blue-50 to-orange-50">
              <CardContent className="p-6">
                <div className="flex items-center gap-6">
                  <Avatar className="w-20 h-20">
                    <AvatarFallback className="bg-gradient-to-br from-blue-600 to-orange-600 text-white text-xl font-bold">
                      {getInitials(profileData.name || 'UN')}
                    </AvatarFallback>
                  </Avatar>
                  <div className="flex-1">
                    <h3 className="text-2xl font-bold text-gray-900 mb-1">{profileData.name || 'Unknown User'}</h3>
                    <p className="text-gray-600 mb-2">{profileData.email}</p>
                    <div className="flex items-center gap-2 mb-2">
                      <Badge className="bg-blue-100 text-blue-800">
                        <Shield className="w-3 h-3 mr-1" />
                        {formatRole(profileData.role)}
                      </Badge>
                      {profileData.sport && (
                        <Badge variant="secondary">
                          {profileData.sport}
                        </Badge>
                      )}
                    </div>
                    <div className="text-sm text-gray-500">
                      <div className="flex items-center gap-1 mb-1">
                        <Calendar className="w-3 h-3" />
                        Joined: {userData?.createdAt ? new Date(userData.createdAt.seconds * 1000).toLocaleDateString() : 'N/A'}
                      </div>
                      <div className="flex items-center gap-1">
                        <User className="w-3 h-3" />
                        User ID: {profileData.userId}
                      </div>
                    </div>
                  </div>
                  <Button 
                    onClick={() => setIsEditing(!isEditing)}
                    variant={isEditing ? "default" : "outline"}
                    className="flex items-center gap-2"
                  >
                    <Edit3 className="w-4 h-4" />
                    {isEditing ? 'Cancel' : 'Edit Profile'}
                  </Button>
                </div>
              </CardContent>
            </Card>
            
            {/* Profile Details */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <User className="h-5 w-5" />
                  Personal Information
                </CardTitle>
                <CardDescription>
                  {isEditing ? 'Edit your personal information and preferences' : 'View your personal information and preferences'}
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid gap-4 md:grid-cols-2">
                  <div className="space-y-2">
                    <Label htmlFor="name" className="flex items-center gap-2">
                      <User className="w-4 h-4" />
                      Full Name
                    </Label>
                    <Input 
                      id="name" 
                      value={profileData.name}
                      onChange={(e) => setProfileData({...profileData, name: e.target.value})}
                      disabled={!isEditing}
                      className={!isEditing ? 'bg-gray-50' : ''}
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="email" className="flex items-center gap-2">
                      <Mail className="w-4 h-4" />
                      Official Email
                    </Label>
                    <Input 
                      id="email" 
                      type="email" 
                      value={profileData.email}
                      disabled={true}
                      className="bg-gray-50"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="phone" className="flex items-center gap-2">
                      <Phone className="w-4 h-4" />
                      Phone Number
                    </Label>
                    <Input 
                      id="phone" 
                      value={profileData.phone}
                      onChange={(e) => setProfileData({...profileData, phone: e.target.value})}
                      disabled={!isEditing}
                      className={!isEditing ? 'bg-gray-50' : ''}
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="sport">Specialization/Sport</Label>
                    <Input 
                      id="sport" 
                      value={profileData.sport}
                      onChange={(e) => setProfileData({...profileData, sport: e.target.value})}
                      disabled={!isEditing}
                      className={!isEditing ? 'bg-gray-50' : ''}
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="height" className="flex items-center gap-2">
                      <Ruler className="w-4 h-4" />
                      Height (cm)
                    </Label>
                    <Input 
                      id="height" 
                      value={profileData.height}
                      onChange={(e) => setProfileData({...profileData, height: e.target.value})}
                      disabled={!isEditing}
                      className={!isEditing ? 'bg-gray-50' : ''}
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="weight" className="flex items-center gap-2">
                      <Weight className="w-4 h-4" />
                      Weight (kg)
                    </Label>
                    <Input 
                      id="weight" 
                      value={profileData.weight}
                      onChange={(e) => setProfileData({...profileData, weight: e.target.value})}
                      disabled={!isEditing}
                      className={!isEditing ? 'bg-gray-50' : ''}
                    />
                  </div>
                </div>
                
                <div className="space-y-2">
                  <Label>Role & Access Level</Label>
                  <div className="p-3 bg-gray-50 rounded-lg border">
                    <div className="flex items-center justify-between">
                      <div>
                        <p className="font-medium">{formatRole(profileData.role)} Access</p>
                        <p className="text-sm text-gray-600">
                          {profileData.role === 'official' 
                            ? 'Full system access including all athletes, academies, and administrative functions'
                            : 'Academy-specific access to assigned athletes and assessments'
                          }
                        </p>
                      </div>
                      <Shield className="w-6 h-6 text-blue-600" />
                    </div>
                  </div>
                </div>

                {isEditing && (
                  <div className="flex gap-2 pt-4">
                    <Button onClick={handleSaveProfile} className="flex items-center gap-2">
                      <Save className="w-4 h-4" />
                      Save Changes
                    </Button>
                    <Button variant="outline" onClick={() => setIsEditing(false)}>
                      Cancel
                    </Button>
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Theme Settings */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <SettingsIcon className="h-5 w-5" />
                  Appearance
                </CardTitle>
                <CardDescription>Customize the look and feel of your dashboard</CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex items-center justify-between">
                  <div className="space-y-0.5">
                    <p className="font-medium">Dark Mode</p>
                    <p className="text-sm text-muted-foreground">Toggle between light and dark themes</p>
                  </div>
                  <Switch />
                </div>
                
                <div className="space-y-2">
                  <Label>Language</Label>
                  <Select defaultValue="english">
                    <SelectTrigger className="w-full">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="english">English</SelectItem>
                      <SelectItem value="hindi">हिंदी (Hindi)</SelectItem>
                      <SelectItem value="tamil">தமிழ் (Tamil)</SelectItem>
                      <SelectItem value="bengali">বাংলা (Bengali)</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          {/* User Management */}
          <TabsContent value="users" className="space-y-6">
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div>
                    <CardTitle className="flex items-center gap-2">
                      <Users className="h-5 w-5" />
                      User Management
                    </CardTitle>
                    <CardDescription>Manage user accounts and permissions</CardDescription>
                  </div>
                  <Button>
                    <User className="mr-2 h-4 w-4" />
                    Add User
                  </Button>
                </div>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {[
                    { name: 'Rajesh Kumar', email: 'rajesh.kumar@sai.gov.in', role: 'Admin', status: 'Active' },
                    { name: 'Priya Singh', email: 'priya.singh@sai.gov.in', role: 'Reviewer', status: 'Active' },
                    { name: 'Amit Sharma', email: 'amit.sharma@sai.gov.in', role: 'Analyst', status: 'Inactive' },
                    { name: 'Neha Patel', email: 'neha.patel@sai.gov.in', role: 'Coach', status: 'Active' },
                  ].map((user, index) => (
                    <div key={index} className="flex items-center justify-between p-4 rounded-lg border">
                      <div className="flex items-center gap-3">
                        <div className="h-10 w-10 rounded-full bg-primary/10 flex items-center justify-center">
                          <User className="h-5 w-5 text-primary" />
                        </div>
                        <div>
                          <p className="font-medium">{user.name}</p>
                          <p className="text-sm text-muted-foreground">{user.email}</p>
                        </div>
                      </div>
                      <div className="flex items-center gap-3">
                        <Badge variant="outline">{user.role}</Badge>
                        <Badge className={user.status === 'Active' ? 'bg-success/10 text-success' : 'bg-muted text-muted-foreground'}>
                          {user.status}
                        </Badge>
                        <Button variant="outline" size="sm">Edit</Button>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          {/* System Settings */}
          <TabsContent value="system" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Database className="h-5 w-5" />
                  System Configuration
                </CardTitle>
                <CardDescription>Configure system-wide settings and preferences</CardDescription>
              </CardHeader>
              <CardContent className="space-y-6">
                <div className="space-y-4">
                  <div className="space-y-2">
                    <Label>Assessment Auto-Approval Threshold</Label>
                    <Select defaultValue="85">
                      <SelectTrigger>
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="90">90% AI Confidence</SelectItem>
                        <SelectItem value="85">85% AI Confidence</SelectItem>
                        <SelectItem value="80">80% AI Confidence</SelectItem>
                        <SelectItem value="manual">Manual Review Only</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>

                  <div className="space-y-2">
                    <Label>Maximum Video Upload Size</Label>
                    <Select defaultValue="100">
                      <SelectTrigger>
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="50">50 MB</SelectItem>
                        <SelectItem value="100">100 MB</SelectItem>
                        <SelectItem value="200">200 MB</SelectItem>
                        <SelectItem value="500">500 MB</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>

                  <div className="flex items-center justify-between">
                    <div className="space-y-0.5">
                      <p className="font-medium">Enable Real-time Analytics</p>
                      <p className="text-sm text-muted-foreground">Update dashboard metrics in real-time</p>
                    </div>
                    <Switch defaultChecked />
                  </div>

                  <div className="flex items-center justify-between">
                    <div className="space-y-0.5">
                      <p className="font-medium">Automatic Backup</p>
                      <p className="text-sm text-muted-foreground">Daily automated system backups</p>
                    </div>
                    <Switch defaultChecked />
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          {/* Security Settings */}
          <TabsContent value="security" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Shield className="h-5 w-5" />
                  Security & Privacy
                </CardTitle>
                <CardDescription>Manage security settings and access controls</CardDescription>
              </CardHeader>
              <CardContent className="space-y-6">
                <div className="space-y-4">
                  <div className="flex items-center justify-between">
                    <div className="space-y-0.5">
                      <p className="font-medium">Two-Factor Authentication</p>
                      <p className="text-sm text-muted-foreground">Add an extra layer of security to your account</p>
                    </div>
                    <Button variant="outline">Configure 2FA</Button>
                  </div>

                  <div className="space-y-2">
                    <Label>Session Timeout</Label>
                    <Select defaultValue="60">
                      <SelectTrigger>
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="30">30 minutes</SelectItem>
                        <SelectItem value="60">1 hour</SelectItem>
                        <SelectItem value="240">4 hours</SelectItem>
                        <SelectItem value="480">8 hours</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>

                  <div className="flex items-center justify-between">
                    <div className="space-y-0.5">
                      <p className="font-medium">IP Address Restriction</p>
                      <p className="text-sm text-muted-foreground">Limit access to specific IP addresses</p>
                    </div>
                    <Switch />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="audit-log">Audit Log Retention</Label>
                    <Select defaultValue="365">
                      <SelectTrigger>
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="30">30 days</SelectItem>
                        <SelectItem value="90">90 days</SelectItem>
                        <SelectItem value="180">180 days</SelectItem>
                        <SelectItem value="365">1 year</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          {/* Notification Settings */}
          <TabsContent value="notifications" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Bell className="h-5 w-5" />
                  Notification Preferences
                </CardTitle>
                <CardDescription>Configure when and how you receive notifications</CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="space-y-4">
                  <div className="flex items-center justify-between">
                    <div className="space-y-0.5">
                      <p className="font-medium">Email Notifications</p>
                      <p className="text-sm text-muted-foreground">Receive updates via email</p>
                    </div>
                    <Switch defaultChecked />
                  </div>

                  <div className="flex items-center justify-between">
                    <div className="space-y-0.5">
                      <p className="font-medium">SMS Alerts</p>
                      <p className="text-sm text-muted-foreground">Critical alerts via SMS</p>
                    </div>
                    <Switch />
                  </div>

                  <div className="flex items-center justify-between">
                    <div className="space-y-0.5">
                      <p className="font-medium">Browser Notifications</p>
                      <p className="text-sm text-muted-foreground">Real-time browser notifications</p>
                    </div>
                    <Switch defaultChecked />
                  </div>

                  <div className="space-y-2">
                    <Label>Notification Frequency</Label>
                    <Select defaultValue="immediate">
                      <SelectTrigger>
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="immediate">Immediate</SelectItem>
                        <SelectItem value="hourly">Hourly Digest</SelectItem>
                        <SelectItem value="daily">Daily Summary</SelectItem>
                        <SelectItem value="weekly">Weekly Report</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </MainLayout>
  );
}