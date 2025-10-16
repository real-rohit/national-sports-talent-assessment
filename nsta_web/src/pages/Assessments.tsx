import { MainLayout } from "@/components/layout/main-layout";
import { Play, Eye, CheckCircle, XCircle, AlertTriangle, Filter, Search } from "lucide-react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useAssessments } from "@/hooks/useFirebaseData";
import { Skeleton } from "@/components/ui/skeleton";

export default function Assessments() {
  const { data: assessments, loading: assessmentsLoading, error: assessmentsError } = useAssessments();
  
  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'Approved':
        return <CheckCircle className="h-4 w-4 text-success" />;
      case 'Flagged':
        return <AlertTriangle className="h-4 w-4 text-warning" />;
      case 'Rejected':
        return <XCircle className="h-4 w-4 text-danger" />;
      default:
        return <Eye className="h-4 w-4 text-muted-foreground" />;
    }
  };

  const getStatusBadge = (status: string) => {
    switch (status) {
      case 'Approved':
        return 'status-approved';
      case 'Flagged':
        return 'status-flagged';
      case 'Rejected':
        return 'status-flagged';
      default:
        return 'status-pending';
    }
  };

  return (
    <MainLayout 
      title="Assessment Review"
      description="Review and validate athlete performance assessments"
    >
      <div className="space-y-6">
        {/* Filters */}
        <Card>
          <CardContent className="pt-6">
            <div className="flex flex-col gap-4 md:flex-row md:items-center">
              <div className="relative flex-1">
                <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                <Input 
                  placeholder="Search by athlete name or assessment ID..." 
                  className="pl-10"
                />
              </div>
              <div className="flex gap-2">
                <Select>
                  <SelectTrigger className="w-[140px]">
                    <SelectValue placeholder="Test Type" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Tests</SelectItem>
                    <SelectItem value="vertical-jump">Vertical Jump</SelectItem>
                    <SelectItem value="sit-ups">Sit-ups</SelectItem>
                    <SelectItem value="shuttle-run">Shuttle Run</SelectItem>
                    <SelectItem value="flexibility">Flexibility</SelectItem>
                  </SelectContent>
                </Select>
                <Select>
                  <SelectTrigger className="w-[120px]">
                    <SelectValue placeholder="Status" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Status</SelectItem>
                    <SelectItem value="pending">Pending</SelectItem>
                    <SelectItem value="approved">Approved</SelectItem>
                    <SelectItem value="flagged">Flagged</SelectItem>
                    <SelectItem value="rejected">Rejected</SelectItem>
                  </SelectContent>
                </Select>
                <Button variant="outline" size="icon">
                  <Filter className="h-4 w-4" />
                </Button>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Assessment Cards */}
        {assessmentsError && (
          <div className="text-center py-8 text-red-600">
            Error loading assessments: {assessmentsError.message}
          </div>
        )}
        
        {assessmentsLoading ? (
          <div className="space-y-4">
            {Array.from({length: 5}).map((_, i) => (
              <Skeleton key={i} className="h-64 w-full" />
            ))}
          </div>
        ) : (
          <div className="space-y-4">
            {assessments?.map((assessment) => (
            <Card key={assessment.id} className="transition-all hover:shadow-lg">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    {getStatusIcon(assessment.status)}
                    <div>
                      <CardTitle className="text-lg">{assessment.athleteName}</CardTitle>
                      <CardDescription>
                        {assessment.testType} • Submitted {new Date(assessment.submissionDate).toLocaleDateString()}
                      </CardDescription>
                    </div>
                  </div>
                  <Badge className={`status-badge ${getStatusBadge(assessment.status)}`}>
                    {assessment.status}
                  </Badge>
                </div>
              </CardHeader>
              
              <CardContent>
                <div className="grid gap-6 lg:grid-cols-2">
                  {/* Video Player Placeholder */}
                  <div className="space-y-4">
                    <div className="aspect-video bg-muted rounded-lg flex items-center justify-center">
                      <div className="text-center">
                        <Play className="h-12 w-12 mx-auto mb-2 text-muted-foreground" />
                        <p className="text-sm text-muted-foreground">Assessment Video</p>
                        <Button variant="outline" size="sm" className="mt-2">
                          <Play className="mr-2 h-4 w-4" />
                          Play Video
                        </Button>
                      </div>
                    </div>
                    
                    {assessment.cheatDetected && (
                      <Card className="border-danger bg-danger-muted">
                        <CardContent className="pt-4">
                          <div className="flex items-center gap-2 text-danger-foreground">
                            <AlertTriangle className="h-5 w-5" />
                            <span className="font-medium">Cheat Detection Alert</span>
                          </div>
                          <p className="text-sm text-danger-foreground/80 mt-1">
                            AI algorithms have detected potential irregularities in this assessment
                          </p>
                        </CardContent>
                      </Card>
                    )}
                  </div>

                  {/* Assessment Details */}
                  <div className="space-y-4">
                    <div className="grid grid-cols-2 gap-4">
                      <div className="space-y-2">
                        <p className="text-sm text-muted-foreground">AI Confidence Score</p>
                        <div className="flex items-center gap-2">
                          <div className="flex-1 bg-secondary rounded-full h-2">
                            <div 
                              className="bg-primary rounded-full h-2 transition-all" 
                              style={{ width: `${assessment.aiScore}%` }}
                            />
                          </div>
                          <span className="text-sm font-semibold">{assessment.aiScore}%</span>
                        </div>
                      </div>
                      
                      <div className="space-y-2">
                        <p className="text-sm text-muted-foreground">Performance Metric</p>
                        <p className="text-lg font-semibold">{assessment.performanceMetric}</p>
                      </div>
                    </div>

                    {assessment.reviewerNotes && (
                      <div className="space-y-2">
                        <p className="text-sm text-muted-foreground">Reviewer Notes</p>
                        <p className="text-sm bg-muted p-3 rounded-lg">{assessment.reviewerNotes}</p>
                      </div>
                    )}

                    <div className="flex gap-2 pt-4">
                      <Button size="sm" className="bg-success text-success-foreground hover:bg-success/90">
                        <CheckCircle className="mr-2 h-4 w-4" />
                        Approve
                      </Button>
                      <Button variant="outline" size="sm">
                        <AlertTriangle className="mr-2 h-4 w-4" />
                        Flag
                      </Button>
                      <Button variant="destructive" size="sm">
                        <XCircle className="mr-2 h-4 w-4" />
                        Reject
                      </Button>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          )) || []}
          </div>
        )}
      </div>
    </MainLayout>
  );
}