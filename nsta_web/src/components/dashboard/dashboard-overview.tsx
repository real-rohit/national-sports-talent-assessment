import { Users, ClipboardCheck, Shield, TrendingUp } from "lucide-react"
import { MetricCard } from "./metric-card"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { useDashboardMetrics, useAssessments, useAnalyticsData } from "@/hooks/useFirebaseData"
import { Skeleton } from "@/components/ui/skeleton"

export function DashboardOverview() {
  const { data: dashboardMetrics, loading: metricsLoading, error: metricsError } = useDashboardMetrics();
  const { data: assessments, loading: assessmentsLoading } = useAssessments({ limit: 5 });
  const { data: analyticsData, loading: analyticsLoading } = useAnalyticsData();
  
  const recentAssessments = assessments?.slice(0, 5) || []

  return (
    <div className="space-y-6">
      {/* Metrics Grid */}
      {metricsError && (
        <div className="text-center py-8 text-red-600">
          Error loading metrics: {metricsError.message}
        </div>
      )}
      
      {metricsLoading ? (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
          {Array.from({length: 4}).map((_, i) => (
            <Skeleton key={i} className="h-32 w-full" />
          ))}
        </div>
      ) : dashboardMetrics ? (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
          <MetricCard
            title="Total Athletes"
            value={dashboardMetrics.totalAthletes.toLocaleString()}
            change={dashboardMetrics.monthlyGrowth}
            changeType="positive"
            icon={Users}
            description="Registered this month"
          />
          <MetricCard
            title="Pending Reviews"
            value={dashboardMetrics.pendingAssessments}
            change="urgent"
            changeType="negative"
            icon={ClipboardCheck}
            description="Awaiting approval"
          />
          <MetricCard
            title="Verified Tests"
            value={dashboardMetrics.verifiedAssessments.toLocaleString()}
            change={dashboardMetrics.approvalRate}
            changeType="positive"
            icon={Shield}
            description="Success rate"
          />
          <MetricCard
            title="Processing Time"
            value={dashboardMetrics.avgProcessingTime}
            change="-15% faster"
            changeType="positive"
            icon={TrendingUp}
            description="Average review time"
          />
        </div>
      ) : null}

      {/* Recent Activity & Quick Stats */}
      <div className="grid gap-6 lg:grid-cols-2">
        {/* Recent Assessments */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-4">
            <div>
              <CardTitle className="text-lg">Recent Assessments</CardTitle>
              <CardDescription>Latest submissions requiring review</CardDescription>
            </div>
            <Button variant="outline" size="sm">View All</Button>
          </CardHeader>
          <CardContent>
            {assessmentsLoading ? (
              <div className="space-y-4">
                {Array.from({length: 5}).map((_, i) => (
                  <Skeleton key={i} className="h-16 w-full" />
                ))}
              </div>
            ) : (
              <div className="space-y-4">
                {recentAssessments.map((assessment) => (
                  <div key={assessment.id} className="flex items-center justify-between p-3 rounded-lg border bg-card">
                    <div className="flex-1">
                      <p className="font-medium text-sm">{assessment.athleteName}</p>
                      <p className="text-xs text-muted-foreground">{assessment.testType}</p>
                    </div>
                    <div className="flex items-center gap-2">
                      <span className="text-xs text-muted-foreground">
                        AI: {assessment.aiScore}%
                      </span>
                      <Badge
                        variant={
                          assessment.status === 'Approved' ? 'default' :
                          assessment.status === 'Flagged' ? 'destructive' : 'secondary'
                        }
                        className="text-xs"
                      >
                        {assessment.status}
                      </Badge>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>

        {/* Performance Distribution */}
        <Card>
          <CardHeader>
            <CardTitle className="text-lg">Performance by State</CardTitle>
            <CardDescription>Top performing regions</CardDescription>
          </CardHeader>
          <CardContent>
            {analyticsLoading ? (
              <div className="space-y-3">
                {Array.from({length: 5}).map((_, i) => (
                  <Skeleton key={i} className="h-16 w-full" />
                ))}
              </div>
            ) : (
              <div className="space-y-3">
                {analyticsData.performanceByState.slice(0, 5).map((state, index) => (
                  <div key={state.state} className="flex items-center justify-between p-3 rounded-lg bg-muted/30">
                    <div className="flex items-center gap-3">
                      <div className="flex h-8 w-8 items-center justify-center rounded-md bg-primary/10 text-primary text-xs font-semibold">
                        #{index + 1}
                      </div>
                      <div>
                        <p className="font-medium text-sm">{state.state}</p>
                        <p className="text-xs text-muted-foreground">{state.athletes} athletes</p>
                      </div>
                    </div>
                    <div className="text-right">
                      <p className="font-semibold text-sm">{state.avgScore}%</p>
                      <p className="text-xs text-muted-foreground">Avg Score</p>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      {/* Alert Section */}
      <Card className="border-warning bg-warning-muted">
        <CardContent className="pt-6">
          <div className="flex items-start gap-4">
            <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-warning text-warning-foreground">
              <Shield className="h-5 w-5" />
            </div>
            <div className="flex-1">
              <h4 className="font-semibold text-warning-foreground">Security Alert</h4>
              <p className="text-sm text-warning-foreground/80 mt-1">
                {dashboardMetrics?.flaggedAssessments || 0} assessments have been flagged for potential cheating.
                Immediate review required to maintain assessment integrity.
              </p>
              <Button variant="outline" size="sm" className="mt-3 border-warning-foreground/20 text-warning-foreground hover:bg-warning-foreground/10">
                Review Flagged Items
              </Button>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}