import { Navigate, Outlet } from "react-router-dom";
import { useAuth } from "@/hooks/useAuth";

export function ProtectedRoute() {
  const { user, userRole, loading } = useAuth();

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-orange-50 flex items-center justify-center">
        <div className="text-center">
          <div className="w-16 h-16 border-4 border-blue-600 border-t-transparent rounded-full animate-spin mx-auto mb-4"></div>
          <p className="text-gray-600">Loading NSTA Portal...</p>
        </div>
      </div>
    );
  }

  // Check for demo user in localStorage
  const demoUserData = localStorage.getItem('demoUser');
  if (demoUserData) {
    try {
      const demoUser = JSON.parse(demoUserData);
      if (demoUser.role === 'official' || demoUser.role === 'academy') {
        return <Outlet />;
      }
    } catch (error) {
      console.error('Error parsing demo user data:', error);
      localStorage.removeItem('demoUser');
    }
  }

  if (!user) {
    return <Navigate to="/login" />;
  }

  // Check if user has appropriate role
  if (!userRole || (userRole !== 'official' && userRole !== 'academy')) {
    return <Navigate to="/login" />;
  }

  return <Outlet />;
}
