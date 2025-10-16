import { MainLayout } from "@/components/layout/main-layout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, PieChart, Pie, Cell, LineChart, Line, ResponsiveContainer } from "recharts";
import { TrendingUp, Users, Trophy, MapPin } from "lucide-react";
import { useAnalyticsData, useAthletes } from "@/hooks/useFirebaseData";
import { Skeleton } from "@/components/ui/skeleton";

const chartColors = {
  primary: "hsl(var(--primary))",
  success: "hsl(var(--success))",
  warning: "hsl(var(--warning))",
  danger: "hsl(var(--danger))",
  muted: "hsl(var(--muted-foreground))"
};

const performanceTrends = [
  { month: 'Jan', average: 72, registered: 420 },
  { month: 'Feb', average: 74, registered: 380 },
  { month: 'Mar', average: 76, registered: 450 },
  { month: 'Apr', average: 75, registered: 520 },
  { month: 'May', average: 78, registered: 480 },
  { month: 'Jun', average: 79, registered: 560 },
];

const testTypeDistribution = [
  { name: 'Vertical Jump', value: 35, count: 1245 },
  { name: 'Sit-ups', value: 28, count: 980 },
  { name: 'Shuttle Run', value: 22, count: 786 },
  { name: 'Flexibility', value: 15, count: 534 },
];

const colors = [chartColors.primary, chartColors.success, chartColors.warning, chartColors.danger];

export default function Analytics() {
  const { data: analyticsData, loading: analyticsLoading, error: analyticsError } = useAnalyticsData();
  const { data: athletes, loading: athletesLoading } = useAthletes({ limit: 5 });
  
  // Mock performance trends data (could be calculated from Firebase data)
  const performanceTrends = [
    { month: 'Jan', average: 72, registered: 420 },
    { month: 'Feb', average: 74, registered: 380 },
    { month: 'Mar', average: 76, registered: 450 },
    { month: 'Apr', average: 75, registered: 520 },
    { month: 'May', average: 78, registered: 480 },
    { month: 'Jun', average: 79, registered: 560 },
  ];
  
  if (analyticsError) {
    return (
      <MainLayout 
        title="Performance Analytics"
        description="Comprehensive insights into athlete performance and trends"
      >
        <div className="text-center py-8 text-red-600">
          Error loading analytics: {analyticsError.message}
        </div>
      </MainLayout>
    );
  }
  
  return (
    <MainLayout 
      title="Performance Analytics"
      description="Comprehensive insights into athlete performance and trends"
    >
      <div className="space-y-6">
        {/* Date Range Selector */}
        <div className="flex justify-between items-center">
          <div className="flex gap-2">
            <Select defaultValue="6months">
              <SelectTrigger className="w-[140px]">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="1month">Last Month</SelectItem>
                <SelectItem value="3months">Last 3 Months</SelectItem>
                <SelectItem value="6months">Last 6 Months</SelectItem>
                <SelectItem value="1year">Last Year</SelectItem>
              </SelectContent>
            </Select>
            <Button variant="outline">Export Report</Button>
          </div>
        </div>

        {/* Key Metrics */}
        {analyticsLoading ? (
          <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
            {Array.from({length: 4}).map((_, i) => (
              <Skeleton key={i} className="h-24 w-full" />
            ))}
          </div>
        ) : (
          <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
            <Card>
              <CardContent className="pt-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">Avg Performance</p>
                    <p className="text-2xl font-bold">
                      {analyticsData.performanceByState.length > 0 
                        ? (analyticsData.performanceByState.reduce((sum, state) => sum + state.avgScore, 0) / analyticsData.performanceByState.length).toFixed(1)
                        : '0'}%
                    </p>
                    <p className="text-xs text-success">+2.4% from last month</p>
                  </div>
                  <TrendingUp className="h-8 w-8 text-primary" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="pt-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">Active States</p>
                    <p className="text-2xl font-bold">{analyticsData.performanceByState.length}</p>
                    <p className="text-xs text-success">+3 new states</p>
                  </div>
                  <MapPin className="h-8 w-8 text-primary" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="pt-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">Top Performers</p>
                    <p className="text-2xl font-bold">
                      {athletes?.filter(a => a.performance?.overallScore >= 85).length || 0}
                    </p>
                    <p className="text-xs text-success">Above 85% score</p>
                  </div>
                  <Trophy className="h-8 w-8 text-primary" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="pt-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">Gender Ratio</p>
                    <p className="text-2xl font-bold">
                      {analyticsData.performanceByGender.length > 0
                        ? `${Math.round(analyticsData.performanceByGender[0]?.percentage || 0)}:${Math.round(analyticsData.performanceByGender[1]?.percentage || 0)}`
                        : '0:0'}
                    </p>
                    <p className="text-xs text-muted-foreground">Male:Female</p>
                  </div>
                  <Users className="h-8 w-8 text-primary" />
                </div>
              </CardContent>
            </Card>
          </div>
        )}

        {/* Charts Grid */}
        <div className="grid gap-6 lg:grid-cols-2">
          {/* Performance Trends */}
          <Card>
            <CardHeader>
              <CardTitle>Performance Trends</CardTitle>
              <CardDescription>Average scores and registrations over time</CardDescription>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={300}>
                <LineChart data={performanceTrends}>
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="month" />
                  <YAxis />
                  <Tooltip />
                  <Line 
                    type="monotone" 
                    dataKey="average" 
                    stroke={chartColors.primary} 
                    strokeWidth={2}
                    name="Avg Score (%)"
                  />
                </LineChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>

          {/* Test Type Distribution */}
          <Card>
            <CardHeader>
              <CardTitle>Assessment Distribution</CardTitle>
              <CardDescription>Breakdown by test type</CardDescription>
            </CardHeader>
            <CardContent>
              {analyticsLoading ? (
                <Skeleton className="h-[300px] w-full" />
              ) : (
                <>
                  <ResponsiveContainer width="100%" height={300}>
                    <PieChart>
                      <Pie
                        data={analyticsData.testTypeDistribution}
                        cx="50%"
                        cy="50%"
                        innerRadius={60}
                        outerRadius={120}
                        paddingAngle={5}
                        dataKey="value"
                      >
                        {analyticsData.testTypeDistribution.map((entry, index) => (
                          <Cell key={`cell-${index}`} fill={colors[index % colors.length]} />
                        ))}
                      </Pie>
                      <Tooltip formatter={(value) => [`${value}%`, 'Percentage']} />
                    </PieChart>
                  </ResponsiveContainer>
                  <div className="mt-4 grid grid-cols-2 gap-2">
                    {analyticsData.testTypeDistribution.map((item, index) => (
                      <div key={item.name} className="flex items-center gap-2">
                        <div 
                          className="w-3 h-3 rounded-full" 
                          style={{ backgroundColor: colors[index % colors.length] }}
                        />
                        <span className="text-xs">{item.name}</span>
                      </div>
                    ))}
                  </div>
                </>
              )}
            </CardContent>
          </Card>
        </div>

        {/* State Performance Rankings */}
        <Card>
          <CardHeader>
            <CardTitle>State Performance Rankings</CardTitle>
            <CardDescription>Top performing states by average athlete scores</CardDescription>
          </CardHeader>
          <CardContent>
            {analyticsLoading ? (
              <Skeleton className="h-[400px] w-full" />
            ) : (
              <ResponsiveContainer width="100%" height={400}>
                <BarChart data={analyticsData.performanceByState}>
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="state" />
                  <YAxis />
                  <Tooltip formatter={(value) => [`${value}%`, 'Average Score']} />
                  <Bar dataKey="avgScore" fill={chartColors.primary} radius={[4, 4, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            )}
          </CardContent>
        </Card>

        {/* Leaderboard */}
        <Card>
          <CardHeader>
            <CardTitle>Top Performing Athletes</CardTitle>
            <CardDescription>Highest scoring athletes this month</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-3">
              {athletesLoading ? (
                Array.from({length: 5}).map((_, i) => (
                  <Skeleton key={i} className="h-16 w-full" />
                ))
              ) : (
                athletes?.sort((a, b) => (b.performance?.overallScore || 0) - (a.performance?.overallScore || 0))
                  .slice(0, 5)
                  .map((athlete, index) => (
                  <div key={athlete.id} className="flex items-center justify-between p-3 rounded-lg bg-muted/30">
                    <div className="flex items-center gap-3">
                      <div className="flex h-8 w-8 items-center justify-center rounded-md bg-primary/10 text-primary text-sm font-bold">
                        #{index + 1}
                      </div>
                      <div>
                        <p className="font-medium text-sm">{athlete.name}</p>
                        <p className="text-xs text-muted-foreground">{athlete.state}</p>
                      </div>
                    </div>
                    <Badge variant="outline" className="font-semibold">
                      {athlete.performance?.overallScore || 0}%
                    </Badge>
                  </div>
                )) || []
              )}
            </div>
          </CardContent>
        </Card>
      </div>
    </MainLayout>
  );
}