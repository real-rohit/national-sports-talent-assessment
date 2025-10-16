import { useState } from "react";
import { signInWithEmailAndPassword, sendPasswordResetEmail } from "firebase/auth";
import { auth, db } from "@/lib/firebase";
import { doc, getDoc } from "firebase/firestore";
import { useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { AlertCircle, Shield, Mail, Lock, ArrowLeft } from "lucide-react";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { toast } from "sonner";

export function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const [forgotPasswordEmail, setForgotPasswordEmail] = useState("");
  const [showForgotPassword, setShowForgotPassword] = useState(false);
  const navigate = useNavigate();

  const checkUserRole = async (userUid: string) => {
    // For demo purposes, first check if this is a known demo email
    const officialEmails = ['rohit@gmail.com', 'admin@sai.gov.in', 'official@nsta.gov.in'];
    const academyEmails = ['aman@nsta.gov.in', 'academy2@sai.gov.in', 'coach@academy.com'];
    
    if (officialEmails.includes(email.toLowerCase()) || academyEmails.includes(email.toLowerCase())) {
      return true;
    }
    
    // If not a demo email, check Firestore for actual user data
    if (!db) throw new Error('Database not initialized');
    
    try {
      const userDoc = await getDoc(doc(db, 'users', userUid));
      if (userDoc.exists()) {
        const userData = userDoc.data();
        return userData.role === 'official' || userData.role === 'academy';
      }
    } catch (error) {
      console.error('Error checking user role:', error);
    }
    
    // If no user document found and not a demo email, deny access
    return false;
  };

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setLoading(true);
    
    try {
      // Check if this is a demo account first
      const officialEmails = ['rohit@gmail.com', 'admin@sai.gov.in', 'official@nsta.gov.in'];
      const academyEmails = ['aman@nsta.gov.in', 'academy2@sai.gov.in', 'coach@academy.com'];
      
      const isDemoAccount = officialEmails.includes(email.toLowerCase()) || academyEmails.includes(email.toLowerCase());
      
      if (isDemoAccount) {
        // For demo accounts, skip Firebase authentication and use localStorage to simulate login
        const demoUser = {
          email: email,
          uid: 'demo_' + email.replace(/[@.]/g, '_'),
          role: officialEmails.includes(email.toLowerCase()) ? 'official' : 'academy'
        };
        
        // Store demo user info in localStorage
        localStorage.setItem('demoUser', JSON.stringify(demoUser));
        
        toast.success('Demo login successful! Welcome to NSTA Portal.');
        navigate("/dashboard");
        setLoading(false);
        return;
      }
      
      // For non-demo accounts, use Firebase authentication
      if (!auth) {
        throw new Error('Auth is not initialized. Check your VITE_ environment variables.');
      }
      
      const userCredential = await signInWithEmailAndPassword(auth, email, password);
      const user = userCredential.user;
      
      // Check if user has appropriate role
      const hasValidRole = await checkUserRole(user.uid);
      
      if (!hasValidRole) {
        // Sign out the user if they don't have valid role
        await auth.signOut();
        setError('Access denied. Only authorized officials can access this system.');
        setLoading(false);
        return;
      }
      
      toast.success('Login successful! Welcome to NSTA Portal.');
      navigate("/dashboard");
    } catch (error: any) {
      if (error.code === 'auth/user-not-found') {
        setError('No account found with this email address.');
      } else if (error.code === 'auth/wrong-password') {
        setError('Incorrect password. Please try again.');
      } else if (error.code === 'auth/invalid-email') {
        setError('Please enter a valid email address.');
      } else if (error.code === 'auth/user-disabled') {
        setError('This account has been disabled. Please contact administrator.');
      } else {
        setError(error.message || 'Login failed. Please try again.');
      }
    } finally {
      setLoading(false);
    }
  };

  const handleForgotPassword = async () => {
    if (!forgotPasswordEmail) {
      toast.error('Please enter your email address.');
      return;
    }
    
    try {
      if (!auth) throw new Error('Auth is not initialized');
      
      await sendPasswordResetEmail(auth, forgotPasswordEmail);
      toast.success('Password reset email sent! Check your inbox.');
      setShowForgotPassword(false);
      setForgotPasswordEmail("");
    } catch (error: any) {
      if (error.code === 'auth/user-not-found') {
        toast.error('No account found with this email address.');
      } else {
        toast.error('Failed to send password reset email. Please try again.');
      }
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-orange-50 flex items-center justify-center p-4">
      {/* Background Pattern */}
      <div className="absolute inset-0 opacity-5">
        <div className="absolute inset-0" style={{
          backgroundImage: `url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23000000' fill-opacity='0.1'%3E%3Ccircle cx='30' cy='30' r='2'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E")`,
        }} />
      </div>
      
      <div className="relative w-full max-w-md">
        {/* Header Section */}
        <div className="text-center mb-8">
          <div className="mx-auto w-20 h-20 rounded-full flex items-center justify-center mb-4 shadow-lg overflow-hidden bg-white">
            <img
              src="/logo.png"
              alt="NSTA Logo"
              className="w-16 h-16 object-contain"
            />
          </div>
          <h1 className="text-3xl font-bold text-gray-900 mb-2">
            NSTA Portal
          </h1>
          <p className="text-gray-600 text-sm">
            National Sports Talent Assessment
          </p>
          <p className="text-gray-500 text-xs mt-1">
            Sports Authority of India
          </p>
        </div>

        {/* Login Card */}
        <Card className="shadow-xl border-0 bg-white/95 backdrop-blur">
          <CardHeader className="space-y-1 pb-6">
            <CardTitle className="text-2xl font-semibold text-center text-gray-900">
              Official Login
            </CardTitle>
            <CardDescription className="text-center text-gray-600">
              Access restricted to authorized personnel only
            </CardDescription>
          </CardHeader>
          
          <CardContent>
            <form onSubmit={handleLogin} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="email" className="text-sm font-medium text-gray-700">
                  Official Email
                </Label>
                <div className="relative">
                  <Mail className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-4 h-4" />
                  <Input
                    id="email"
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="official@nsta.gov.in"
                    className="pl-10 h-11 border-gray-200 focus:border-blue-500 focus:ring-blue-500"
                    required
                  />
                </div>
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="password" className="text-sm font-medium text-gray-700">
                  Password
                </Label>
                <div className="relative">
                  <Lock className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-4 h-4" />
                  <Input
                    id="password"
                    type="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="Enter your password"
                    className="pl-10 h-11 border-gray-200 focus:border-blue-500 focus:ring-blue-500"
                    required
                  />
                </div>
              </div>

              {error && (
                <Alert variant="destructive" className="bg-red-50 border-red-200">
                  <AlertCircle className="h-4 w-4" />
                  <AlertDescription>{error}</AlertDescription>
                </Alert>
              )}

              <Button 
                type="submit" 
                className="w-full h-11 bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-medium"
                disabled={loading}
              >
                {loading ? (
                  <div className="flex items-center gap-2">
                    <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                    Signing In...
                  </div>
                ) : (
                  'Sign In'
                )}
              </Button>
            </form>

            {/* Forgot Password */}
            <div className="mt-4 text-center">
              <Dialog open={showForgotPassword} onOpenChange={setShowForgotPassword}>
                <DialogTrigger asChild>
                  <Button variant="link" className="text-sm text-blue-600 hover:text-blue-800">
                    Forgot your password?
                  </Button>
                </DialogTrigger>
                <DialogContent className="sm:max-w-md">
                  <DialogHeader>
                    <DialogTitle>Reset Password</DialogTitle>
                    <DialogDescription>
                      Enter your official email address and we'll send you a link to reset your password.
                    </DialogDescription>
                  </DialogHeader>
                  <div className="space-y-4 py-4">
                    <div className="space-y-2">
                      <Label htmlFor="forgot-email">Email Address</Label>
                      <Input
                        id="forgot-email"
                        type="email"
                        value={forgotPasswordEmail}
                        onChange={(e) => setForgotPasswordEmail(e.target.value)}
                        placeholder="official@nsta.gov.in"
                      />
                    </div>
                  </div>
                  <DialogFooter>
                    <Button variant="outline" onClick={() => setShowForgotPassword(false)}>
                      Cancel
                    </Button>
                    <Button onClick={handleForgotPassword}>
                      Send Reset Link
                    </Button>
                  </DialogFooter>
                </DialogContent>
              </Dialog>
            </div>

            {/* Demo Credentials Note */}
            <div className="mt-6 p-3 bg-blue-50 border border-blue-200 rounded-lg">
              <p className="text-xs text-blue-800 text-center mb-2">
                <strong>Demo Access Options:</strong>
              </p>
              <div className="text-xs text-blue-700 space-y-1">
                <p><strong>Official Role:</strong> rohit@gmail.com</p>
                <p><strong>Academy Role:</strong> aman@nsta.gov.in</p>
                <p className="text-blue-600 mt-2">Use any password for demo accounts</p>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Footer */}
        <div className="mt-6 text-center text-xs text-gray-500">
          <p>© 2024 Sports Authority of India. All rights reserved.</p>
          <p className="mt-1">National Sports Talent Assessment Program</p>
        </div>
      </div>
    </div>
  );
}
