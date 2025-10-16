import { MainLayout } from "@/components/layout/main-layout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Switch } from "@/components/ui/switch";
import { Bell, AlertTriangle, CheckCircle, Clock, Users, Flag } from "lucide-react";

const notifications = [
  {
    id: 1,
    type: 'alert',
    title: 'Cheat Detection Alert',
    message: 'Assessment ASS003 by Rohit Singh has been flagged for potential cheating',
    timestamp: '2 minutes ago',
    priority: 'high',
    unread: true,
  },
  {
    id: 2,
    type: 'approval',
    title: 'Assessment Approved',
    message: 'Arjun Kumar\'s vertical jump assessment has been successfully approved',
    timestamp: '15 minutes ago',
    priority: 'normal',
    unread: true,
  },
  {
    id: 3,
    type: 'system',
    title: 'New Athlete Registration',
    message: '12 new athletes registered from Punjab region',
    timestamp: '1 hour ago',
    priority: 'normal',
    unread: true,
  },
  {
    id: 4,
    type: 'reminder',
    title: 'Pending Reviews',
    message: '23 assessments are pending review and require immediate attention',
    timestamp: '2 hours ago',
    priority: 'medium',
    unread: false,
  },
  {
    id: 5,
    type: 'system',
    title: 'Weekly Report Ready',
    message: 'Your weekly performance report is ready for download',
    timestamp: '1 day ago',
    priority: 'low',
    unread: false,
  },
];

export default function Notifications() {
  const getNotificationIcon = (type: string) => {
    switch (type) {
      case 'alert':
        return <AlertTriangle className="h-5 w-5 text-danger" />;
      case 'approval':
        return <CheckCircle className="h-5 w-5 text-success" />;
      case 'system':
        return <Bell className="h-5 w-5 text-primary" />;
      case 'reminder':
        return <Clock className="h-5 w-5 text-warning" />;
      default:
        return <Bell className="h-5 w-5 text-muted-foreground" />;
    }
  };

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'high':
        return 'bg-danger text-danger-foreground';
      case 'medium':
        return 'bg-warning text-warning-foreground';
      case 'low':
        return 'bg-muted text-muted-foreground';
      default:
        return 'bg-primary text-primary-foreground';
    }
  };

  return (
    <MainLayout 
      title="Notifications"
      description="Stay updated with important alerts and system notifications"
    >
      <div className="space-y-6">
        {/* Notification Settings */}
        <Card>
          <CardHeader>
            <CardTitle>Notification Preferences</CardTitle>
            <CardDescription>Configure when and how you receive notifications</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div className="space-y-0.5">
                  <p className="font-medium">Cheat Detection Alerts</p>
                  <p className="text-sm text-muted-foreground">Immediate notifications for flagged assessments</p>
                </div>
                <Switch defaultChecked />
              </div>
              
              <div className="flex items-center justify-between">
                <div className="space-y-0.5">
                  <p className="font-medium">Assessment Approvals</p>
                  <p className="text-sm text-muted-foreground">Updates when assessments are approved or rejected</p>
                </div>
                <Switch defaultChecked />
              </div>
              
              <div className="flex items-center justify-between">
                <div className="space-y-0.5">
                  <p className="font-medium">New Registrations</p>
                  <p className="text-sm text-muted-foreground">Notifications for new athlete registrations</p>
                </div>
                <Switch />
              </div>
              
              <div className="flex items-center justify-between">
                <div className="space-y-0.5">
                  <p className="font-medium">Weekly Reports</p>
                  <p className="text-sm text-muted-foreground">Automated report generation notifications</p>
                </div>
                <Switch defaultChecked />
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Quick Actions */}
        <div className="flex gap-4">
          <Button>
            <CheckCircle className="mr-2 h-4 w-4" />
            Mark All as Read
          </Button>
          <Button variant="outline">
            <Bell className="mr-2 h-4 w-4" />
            Clear All
          </Button>
        </div>

        {/* Notifications List */}
        <div className="space-y-4">
          {notifications.map((notification) => (
            <Card 
              key={notification.id} 
              className={`transition-all hover:shadow-lg ${
                notification.unread ? 'border-l-4 border-l-primary bg-primary/5' : ''
              }`}
            >
              <CardContent className="pt-6">
                <div className="flex items-start gap-4">
                  <div className="flex-shrink-0">
                    {getNotificationIcon(notification.type)}
                  </div>
                  
                  <div className="flex-1 space-y-2">
                    <div className="flex items-start justify-between">
                      <div className="space-y-1">
                        <div className="flex items-center gap-2">
                          <h4 className="font-semibold text-sm">{notification.title}</h4>
                          {notification.unread && (
                            <div className="h-2 w-2 rounded-full bg-primary" />
                          )}
                        </div>
                        <p className="text-sm text-muted-foreground">{notification.message}</p>
                      </div>
                      
                      <div className="flex items-center gap-2">
                        <Badge className={getPriorityColor(notification.priority)} variant="outline">
                          {notification.priority}
                        </Badge>
                        <span className="text-xs text-muted-foreground whitespace-nowrap">
                          {notification.timestamp}
                        </span>
                      </div>
                    </div>
                    
                    <div className="flex gap-2">
                      {notification.type === 'alert' && (
                        <>
                          <Button size="sm" variant="outline">
                            <Flag className="mr-2 h-3 w-3" />
                            Review
                          </Button>
                          <Button size="sm" variant="outline">
                            Dismiss
                          </Button>
                        </>
                      )}
                      
                      {notification.type === 'approval' && (
                        <Button size="sm" variant="outline">
                          <Users className="mr-2 h-3 w-3" />
                          View Athlete
                        </Button>
                      )}
                      
                      {notification.type === 'system' && (
                        <Button size="sm" variant="outline">
                          View Details
                        </Button>
                      )}
                      
                      {notification.type === 'reminder' && (
                        <Button size="sm" variant="outline">
                          <CheckCircle className="mr-2 h-3 w-3" />
                          Review Now
                        </Button>
                      )}
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>

        {/* Load More */}
        <div className="text-center">
          <Button variant="outline">Load More Notifications</Button>
        </div>
      </div>
    </MainLayout>
  );
}