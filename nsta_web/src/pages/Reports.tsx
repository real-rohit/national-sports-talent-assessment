import { MainLayout } from "@/components/layout/main-layout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Calendar } from "@/components/ui/calendar";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { Download, FileSpreadsheet, FileText, Calendar as CalendarIcon, Clock, CheckCircle } from "lucide-react";
import { useState } from "react";
import { format } from "date-fns";

const reportTemplates = [
  {
    id: 'performance',
    title: 'Athlete Performance Report',
    description: 'Comprehensive analysis of individual athlete performance across all assessments',
    type: 'Performance',
    format: ['PDF', 'Excel'],
    frequency: 'On-demand',
    lastGenerated: '2024-03-10',
  },
  {
    id: 'state-analysis',
    title: 'State-wise Analysis Report',
    description: 'Regional performance comparison and talent distribution analysis',
    type: 'Analytics',
    format: ['PDF', 'Excel'],
    frequency: 'Monthly',
    lastGenerated: '2024-03-01',
  },
  {
    id: 'assessment-summary',
    title: 'Assessment Summary Report',
    description: 'Weekly summary of assessment submissions, approvals, and flags',
    type: 'Operations',
    format: ['PDF'],
    frequency: 'Weekly',
    lastGenerated: '2024-03-08',
  },
  {
    id: 'talent-identification',
    title: 'Talent Identification Report',
    description: 'Shortlist of high-performing athletes for advanced training programs',
    type: 'Talent',
    format: ['PDF', 'Excel'],
    frequency: 'Quarterly',
    lastGenerated: '2024-01-15',
  },
  {
    id: 'cheat-detection',
    title: 'Security & Integrity Report',
    description: 'Analysis of flagged assessments and potential security breaches',
    type: 'Security',
    format: ['PDF'],
    frequency: 'Monthly',
    lastGenerated: '2024-03-01',
  },
  {
    id: 'coach-dashboard',
    title: 'Coach Performance Dashboard',
    description: 'Regional coach performance and athlete development metrics',
    type: 'Coaching',
    format: ['PDF', 'Excel'],
    frequency: 'Quarterly',
    lastGenerated: '2024-01-15',
  },
];

export default function Reports() {
  const [selectedDate, setSelectedDate] = useState<Date>();
  const [generatingReport, setGeneratingReport] = useState<string | null>(null);

  const handleGenerateReport = (reportId: string) => {
    setGeneratingReport(reportId);
    // Simulate report generation
    setTimeout(() => {
      setGeneratingReport(null);
    }, 2000);
  };

  const getTypeColor = (type: string) => {
    switch (type) {
      case 'Performance':
        return 'bg-primary/10 text-primary';
      case 'Analytics':
        return 'bg-success/10 text-success';
      case 'Operations':
        return 'bg-warning/10 text-warning';
      case 'Talent':
        return 'bg-purple-100 text-purple-700';
      case 'Security':
        return 'bg-danger/10 text-danger';
      case 'Coaching':
        return 'bg-blue-100 text-blue-700';
      default:
        return 'bg-muted text-muted-foreground';
    }
  };

  return (
    <MainLayout 
      title="Reports & Export"
      description="Generate and export comprehensive performance reports"
    >
      <div className="space-y-6">
        {/* Quick Actions */}
        <div className="grid gap-4 md:grid-cols-3">
          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center gap-3">
                <FileSpreadsheet className="h-8 w-8 text-primary" />
                <div>
                  <p className="font-semibold">Quick Export</p>
                  <p className="text-sm text-muted-foreground">Export current athlete data</p>
                </div>
              </div>
              <Button className="w-full mt-4" variant="outline">
                <Download className="mr-2 h-4 w-4" />
                Export to Excel
              </Button>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center gap-3">
                <Calendar className="h-8 w-8 text-success" />
                <div>
                  <p className="font-semibold">Scheduled Reports</p>
                  <p className="text-sm text-muted-foreground">Automated report delivery</p>
                </div>
              </div>
              <Button className="w-full mt-4" variant="outline">
                <Clock className="mr-2 h-4 w-4" />
                Manage Schedule
              </Button>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center gap-3">
                <FileText className="h-8 w-8 text-warning" />
                <div>
                  <p className="font-semibold">Custom Report</p>
                  <p className="text-sm text-muted-foreground">Build custom analytics</p>
                </div>
              </div>
              <Button className="w-full mt-4" variant="outline">
                Create Custom
              </Button>
            </CardContent>
          </Card>
        </div>

        {/* Report Filters */}
        <Card>
          <CardContent className="pt-6">
            <div className="flex flex-col gap-4 md:flex-row md:items-center">
              <div className="flex gap-2">
                <Select>
                  <SelectTrigger className="w-[140px]">
                    <SelectValue placeholder="Report Type" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Reports</SelectItem>
                    <SelectItem value="performance">Performance</SelectItem>
                    <SelectItem value="analytics">Analytics</SelectItem>
                    <SelectItem value="operations">Operations</SelectItem>
                    <SelectItem value="talent">Talent</SelectItem>
                    <SelectItem value="security">Security</SelectItem>
                  </SelectContent>
                </Select>

                <Popover>
                  <PopoverTrigger asChild>
                    <Button variant="outline" className="w-[240px] justify-start text-left font-normal">
                      <CalendarIcon className="mr-2 h-4 w-4" />
                      {selectedDate ? format(selectedDate, "PPP") : "Select date range"}
                    </Button>
                  </PopoverTrigger>
                  <PopoverContent className="w-auto p-0" align="start">
                    <Calendar
                      mode="single"
                      selected={selectedDate}
                      onSelect={setSelectedDate}
                      initialFocus
                    />
                  </PopoverContent>
                </Popover>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Report Templates */}
        <div className="grid gap-4 lg:grid-cols-2">
          {reportTemplates.map((report) => (
            <Card key={report.id} className="transition-all hover:shadow-lg">
              <CardHeader>
                <div className="flex items-start justify-between">
                  <div className="space-y-2">
                    <div className="flex items-center gap-2">
                      <CardTitle className="text-lg">{report.title}</CardTitle>
                      <Badge className={getTypeColor(report.type)} variant="outline">
                        {report.type}
                      </Badge>
                    </div>
                    <CardDescription className="text-sm">
                      {report.description}
                    </CardDescription>
                  </div>
                </div>
              </CardHeader>

              <CardContent className="space-y-4">
                <div className="grid grid-cols-2 gap-4 text-sm">
                  <div>
                    <p className="text-muted-foreground">Format</p>
                    <div className="flex gap-1 mt-1">
                      {report.format.map((fmt) => (
                        <Badge key={fmt} variant="outline" className="text-xs">
                          {fmt}
                        </Badge>
                      ))}
                    </div>
                  </div>
                  <div>
                    <p className="text-muted-foreground">Frequency</p>
                    <p className="font-medium mt-1">{report.frequency}</p>
                  </div>
                </div>

                <div className="flex items-center justify-between pt-2 border-t">
                  <div className="text-sm">
                    <p className="text-muted-foreground">Last Generated</p>
                    <p className="font-medium">{new Date(report.lastGenerated).toLocaleDateString()}</p>
                  </div>
                  
                  <div className="flex gap-2">
                    <Button 
                      variant="outline" 
                      size="sm"
                      onClick={() => handleGenerateReport(report.id)}
                      disabled={generatingReport === report.id}
                    >
                      {generatingReport === report.id ? (
                        <>
                          <Clock className="mr-2 h-4 w-4 animate-spin" />
                          Generating...
                        </>
                      ) : (
                        <>
                          <Download className="mr-2 h-4 w-4" />
                          Generate
                        </>
                      )}
                    </Button>
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>

        {/* Recent Reports */}
        <Card>
          <CardHeader>
            <CardTitle>Recent Reports</CardTitle>
            <CardDescription>Recently generated reports available for download</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-3">
              {[
                { name: 'March Performance Summary.pdf', size: '2.3 MB', date: '2024-03-10', status: 'Ready' },
                { name: 'State Analysis Q1 2024.xlsx', size: '4.7 MB', date: '2024-03-08', status: 'Ready' },
                { name: 'Weekly Assessment Report.pdf', size: '1.8 MB', date: '2024-03-05', status: 'Ready' },
                { name: 'Talent Identification Jan-Mar.xlsx', size: '3.2 MB', date: '2024-03-01', status: 'Ready' },
              ].map((file, index) => (
                <div key={index} className="flex items-center justify-between p-3 rounded-lg bg-muted/30">
                  <div className="flex items-center gap-3">
                    <FileText className="h-5 w-5 text-primary" />
                    <div>
                      <p className="font-medium text-sm">{file.name}</p>
                      <p className="text-xs text-muted-foreground">{file.size} • {file.date}</p>
                    </div>
                  </div>
                  <div className="flex items-center gap-2">
                    <Badge className="bg-success/10 text-success">
                      <CheckCircle className="mr-1 h-3 w-3" />
                      {file.status}
                    </Badge>
                    <Button variant="outline" size="sm">
                      <Download className="h-4 w-4" />
                    </Button>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>
    </MainLayout>
  );
}