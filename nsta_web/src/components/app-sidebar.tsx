import { 
  LayoutDashboard, 
  Users, 
  ClipboardCheck, 
  BarChart3, 
  FileSpreadsheet, 
  Settings,
  Shield,
  Bell
} from "lucide-react"
import { NavLink, useLocation } from "react-router-dom"
import { useAthletes, useAssessments } from "@/hooks/useFirebaseData"
import { useAuth } from "@/hooks/useAuth"

import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  useSidebar,
} from "@/components/ui/sidebar"
import { Badge } from "@/components/ui/badge"

const mainItems = [
  { 
    title: "Dashboard", 
    url: "/", 
    icon: LayoutDashboard,
    badge: null
  },
  { 
    title: "Athletes", 
    url: "/athletes", 
    icon: Users,
    badge: "2,847"
  },
  { 
    title: "Assessments", 
    url: "/assessments", 
    icon: ClipboardCheck,
    badge: "127"
  },
  { 
    title: "Analytics", 
    url: "/analytics", 
    icon: BarChart3,
    badge: null
  },
  { 
    title: "Reports", 
    url: "/reports", 
    icon: FileSpreadsheet,
    badge: null
  },
]

const systemItems = [
  { 
    title: "Notifications", 
    url: "/notifications", 
    icon: Bell,
    badge: "3"
  },
  { 
    title: "Settings", 
    url: "/settings", 
    icon: Settings,
    badge: null
  },
]

export function AppSidebar() {
  const { state } = useSidebar()
  const location = useLocation()
  const { userRole, userData } = useAuth()
  
  // Apply role-based filtering for data
  const athleteFilters = userRole === 'academy' && userData?.academyId 
    ? { academyId: userData.academyId }
    : {};
  
  const assessmentFilters = userRole === 'academy' && userData?.academyId
    ? { status: 'Pending', academyId: userData.academyId }
    : { status: 'Pending' };
  
  // Get dynamic data for badges
  const { data: athletes } = useAthletes(athleteFilters)
  const { data: pendingAssessments } = useAssessments(assessmentFilters)
  
  // Update main items with dynamic badges and role-based access
  const baseMainItems = [
    { 
      title: "Dashboard", 
      url: "/dashboard", 
      icon: LayoutDashboard,
      badge: null,
      roles: ['official', 'academy']
    },
    { 
      title: userRole === 'academy' ? 'My Athletes' : 'Athletes', 
      url: "/athletes", 
      icon: Users,
      badge: athletes?.length?.toString() || "0",
      roles: ['official', 'academy']
    },
    { 
      title: "Assessments", 
      url: "/assessments", 
      icon: ClipboardCheck,
      badge: pendingAssessments?.length?.toString() || "0",
      roles: ['official', 'academy']
    },
    { 
      title: "Analytics", 
      url: "/analytics", 
      icon: BarChart3,
      badge: null,
      roles: ['official', 'academy']
    },
    { 
      title: "Reports", 
      url: "/reports", 
      icon: FileSpreadsheet,
      badge: null,
      roles: ['official', 'academy']
    },
  ];
  
  // Filter items based on user role
  const dynamicMainItems = baseMainItems.filter(item => 
    !item.roles || item.roles.includes(userRole as string)
  );

  const isCollapsed = state === "collapsed"

  // Per-item active color mapping
  const activeClassMap: Record<string, string> = {
    Dashboard: "bg-primary text-primary-foreground font-medium",
    Athletes: "bg-success text-success-foreground font-medium",
    Assessments: "bg-warning text-warning-foreground font-medium",
  }

  const defaultActive = "bg-primary text-primary-foreground font-medium"
  const defaultInactive = "text-muted-foreground hover:bg-sidebar-accent hover:text-sidebar-accent-foreground"

  const getNavCls = (title: string, isActive: boolean) =>
    isActive ? (activeClassMap[title] ?? defaultActive) : defaultInactive

  return (
    <Sidebar
      className={isCollapsed ? "w-16" : "w-64"}
      collapsible="icon"
    >
      <SidebarHeader className="border-b border-sidebar-border p-4">
        <div className="flex items-center gap-3">
          <div className="flex h-8 w-8 items-center justify-center rounded-md bg-primary text-primary-foreground">
        <img
          src="/logo.png"
          alt="NSTA Logo"
          className="h-6 w-6 object-contain"
        />
          </div>
          {!isCollapsed && (
            <div>
              <h2 className="text-sm font-semibold text-sidebar-primary">
                {userRole === 'academy' ? userData?.academyName || 'Academy Portal' : 'NSTA Admin'}
              </h2>
              <p className="text-xs text-sidebar-foreground/70">
                {userRole === 'academy' ? 'Academy Management Portal' : 'National Sports Talent Assessment'}
              </p>
            </div>
          )}
        </div>
      </SidebarHeader>

      <SidebarContent className="px-2 py-4">
        <SidebarGroup>
          <SidebarGroupLabel className={isCollapsed ? "sr-only" : ""}>
            {userRole === 'academy' ? 'Academy Management' : 'Main Navigation'}
          </SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {dynamicMainItems.map((item) => (
                <SidebarMenuItem key={item.title}>
                  <SidebarMenuButton asChild>
                    <NavLink 
                      to={item.url} 
                      end 
                      className={(nav) => getNavCls(item.title, nav.isActive)}
                    >
                      <item.icon className="h-4 w-4" />
                      {!isCollapsed && (
                        <>
                          <span className="flex-1">{item.title}</span>
                          {item.badge && (
                            <Badge variant="secondary" className="ml-auto text-xs">
                              {item.badge}
                            </Badge>
                          )}
                        </>
                      )}
                    </NavLink>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>

        <SidebarGroup className="mt-6">
          <SidebarGroupLabel className={isCollapsed ? "sr-only" : ""}>
            System
          </SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {systemItems.map((item) => (
                <SidebarMenuItem key={item.title}>
                  <SidebarMenuButton asChild>
                    <NavLink 
                      to={item.url} 
                      end 
                      className={(nav) => getNavCls(item.title, nav.isActive)}
                    >
                      <item.icon className="h-4 w-4" />
                      {!isCollapsed && (
                        <>
                          <span className="flex-1">{item.title}</span>
                          {item.badge && (
                            <Badge variant="destructive" className="ml-auto text-xs">
                              {item.badge}
                            </Badge>
                          )}
                        </>
                      )}
                    </NavLink>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>
    </Sidebar>
  )
}