import { useAuth } from "@/hooks/useAuth";
import { MainLayout } from "@/components/layout/main-layout";
import { DashboardOverview } from "@/components/dashboard/dashboard-overview";
import { signOut } from "firebase/auth";
import { auth } from "@/lib/firebase";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { useNavigate } from "react-router-dom";
import { Shield, LogOut, User } from "lucide-react";

const Index = () => {
  const { user, userData, userRole } = useAuth();
  const navigate = useNavigate();
  
  const handleLogout = async () => {
    try {
      // Check if this is a demo user
      const demoUserData = localStorage.getItem('demoUser');
      if (demoUserData) {
        // Clear demo user data from localStorage
        localStorage.removeItem('demoUser');
        navigate("/login");
        return;
      }
      
      // Handle Firebase logout
      if (auth) {
        await signOut(auth);
      } else {
        console.warn('[auth] signOut skipped because auth is not initialized');
      }
      navigate("/login");
    } catch (error) {
      console.error("Failed to log out", error);
    }
  };

  return (
    <MainLayout
      title="National Sports Talent Assessment Portal"
      description="NSTA Athletes Performance Dashboard"
    >
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <div className="flex items-center gap-4">
            <div className="w-12 h-12 rounded-lg flex items-center justify-center bg-white shadow-sm border">
              <img
                src="/logo.png"
                alt="NSTA Logo"
                className="w-10 h-10 object-contain"
              />
            </div>
            <div>
              <h2 className="text-2xl font-bold text-gray-900">
                Welcome, {userData?.name || user?.email}
              </h2>
              <div className="flex items-center gap-2">
                <p className="text-muted-foreground">National Sports Talent Assessment Dashboard</p>
                <Badge className="bg-blue-100 text-blue-800">
                  <User className="w-3 h-3 mr-1" />
                  {userRole?.charAt(0).toUpperCase()}{userRole?.slice(1)}
                </Badge>
              </div>
            </div>
          </div>
          <Button onClick={handleLogout} variant="outline" className="flex items-center gap-2">
            <LogOut className="w-4 h-4" />
            Logout
          </Button>
        </div>
        
        {/* Dashboard Overview */}
        <DashboardOverview />
      </div>
    </MainLayout>
  );
};

export default Index;
