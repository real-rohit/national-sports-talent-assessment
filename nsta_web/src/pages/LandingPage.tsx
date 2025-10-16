import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { 
  Shield, 
  Users, 
  BarChart3, 
  Trophy, 
  Play, 
  ArrowRight, 
  CheckCircle, 
  Star,
  Target,
  Zap,
  Globe,
  Award,
  TrendingUp,
  Activity,
  Eye,
  Brain,
  Rocket
} from 'lucide-react';

const LandingPage = () => {
  const navigate = useNavigate();
  const [activeFeature, setActiveFeature] = useState(0);

  const features = [
    {
      icon: Brain,
      title: "AI-Powered Assessment",
      description: "Advanced computer vision algorithms analyze athletic performance with 95% accuracy",
      details: "Our patent-pending AI technology processes movement patterns in real-time, providing objective performance metrics that eliminate human bias."
    },
    {
      icon: Eye,
      title: "Real-time Analysis",
      description: "Instant performance feedback and detailed movement analysis",
      details: "Get immediate insights into athletic performance with our cutting-edge motion capture technology that works from any smart device."
    },
    {
      icon: Shield,
      title: "Secure & Compliant",
      description: "Government-grade security with complete data privacy protection",
      details: "Built to meet the highest security standards with end-to-end encryption and full compliance with Indian data protection regulations."
    },
    {
      icon: TrendingUp,
      title: "Performance Tracking",
      description: "Comprehensive analytics and progress monitoring over time",
      details: "Track athlete development with detailed performance metrics, trend analysis, and benchmarking against national standards."
    }
  ];

  const stats = [
    { number: "50,000+", label: "Athletes Assessed", icon: Users },
    { number: "95%", label: "AI Accuracy", icon: Target },
    { number: "28", label: "States Covered", icon: Globe },
    { number: "12", label: "Sports Disciplines", icon: Trophy }
  ];

  const testimonials = [
    {
      name: "Dr. Rajesh Kumar",
      role: "Director, SAI Regional Centre",
      content: "NSTA has revolutionized how we identify and nurture sporting talent. The AI-powered assessments provide objective insights that were previously impossible to achieve.",
      avatar: "RK"
    },
    {
      name: "Priya Sharma",
      role: "National Level Coach",
      content: "The detailed movement analysis helps me understand each athlete's strengths and areas for improvement. It's like having a biomechanics expert available 24/7.",
      avatar: "PS"
    },
    {
      name: "Coach Amit Singh",
      role: "State Athletics Coach",
      content: "The real-time feedback and comprehensive reporting have significantly improved our training programs and athlete development strategies.",
      avatar: "AS"
    }
  ];

  return (
    <div className="min-h-screen bg-white">
      {/* Navigation */}
      <nav className="fixed top-0 left-0 right-0 z-50 bg-white/95 backdrop-blur-md border-b border-gray-100">
        <div className="container mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-3">
              <div className="w-10 h-10 rounded-lg flex items-center justify-center bg-white shadow-sm">
                <img
                  src="/logo.png"
                  alt="NSTA Logo"
                  className="w-8 h-8 object-contain"
                />
              </div>
              <div>
                <h1 className="text-xl font-bold text-gray-900">NSTA</h1>
                <p className="text-xs text-gray-500">Sports Authority of India</p>
              </div>
            </div>
            
            <div className="hidden md:flex items-center space-x-8">
              <a href="#features" className="text-gray-600 hover:text-gray-900 transition-colors">Features</a>
              <a href="#technology" className="text-gray-600 hover:text-gray-900 transition-colors">Technology</a>
              <a href="#testimonials" className="text-gray-600 hover:text-gray-900 transition-colors">Testimonials</a>
              <a href="#contact" className="text-gray-600 hover:text-gray-900 transition-colors">Contact</a>
            </div>
            
            <Button 
              onClick={() => navigate('/login')}
              className="bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800"
            >
              Admin Panel
              <ArrowRight className="ml-2 w-4 h-4" />
            </Button>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="pt-24 pb-16 bg-gradient-to-br from-blue-50 via-white to-orange-50">
        <div className="container mx-auto px-6">
          <div className="grid lg:grid-cols-2 gap-12 items-center">
            <div className="space-y-8">
              <div className="space-y-4">
                <Badge className="bg-blue-100 text-blue-800 hover:bg-blue-100">
                  <Rocket className="w-3 h-3 mr-1" />
                  Supported by Sports Authority of India
                </Badge>
                <h1 className="text-5xl lg:text-6xl font-bold text-gray-900 leading-tight">
                  Elevate Athletic
                  <span className="bg-gradient-to-r from-blue-600 to-orange-600 bg-clip-text text-transparent"> Performance</span>
                </h1>
                <p className="text-xl text-gray-600 leading-relaxed">
                  Harness the power of AI-driven movement analysis to identify, assess, and nurture India's sporting talent with unprecedented precision and objectivity.
                </p>
              </div>
              
              <div className="flex flex-col sm:flex-row gap-4">
                <Button 
                  size="lg"
                  onClick={() => navigate('/login')}
                  className="bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-lg px-8 py-6"
                >
                  Access Portal
                  <ArrowRight className="ml-2 w-5 h-5" />
                </Button>
                <Button 
                  variant="outline" 
                  size="lg"
                  className="text-lg px-8 py-6 border-2"
                  onClick={() => window.open("https://drive.google.com/drive/folders/1QiKBBC2VggQW9Yrc4RwPhh-LkDAy83mE?usp=sharing", "_blank")}
                >
                  <Play className="mr-2 w-5 h-5" />
                  Watch Demo
                </Button>
              </div>
              
              <div className="flex items-center space-x-8">
                {stats.slice(0, 2).map((stat, index) => (
                  <div key={index} className="text-center">
                    <div className="text-3xl font-bold text-gray-900">{stat.number}</div>
                    <div className="text-sm text-gray-600">{stat.label}</div>
                  </div>
                ))}
              </div>
            </div>
            
            <div className="relative">
              <div className="absolute inset-0 bg-gradient-to-r from-blue-400 to-orange-400 rounded-3xl blur-3xl opacity-20"></div>
              <Card className="relative bg-white/80 backdrop-blur-sm border-0 shadow-2xl">
                <CardHeader>
                  <CardTitle className="flex items-center gap-3">
                    <Activity className="w-6 h-6 text-blue-600" />
                    Live Performance Analysis
                  </CardTitle>
                  <CardDescription>Real-time AI assessment in progress</CardDescription>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div className="bg-blue-50 p-3 rounded-lg">
                      <div className="text-2xl font-bold text-blue-600">92%</div>
                      <div className="text-sm text-gray-600">Performance Score</div>
                    </div>
                    <div className="bg-green-50 p-3 rounded-lg">
                      <div className="text-2xl font-bold text-green-600">8.2s</div>
                      <div className="text-sm text-gray-600">Shuttle Run</div>
                    </div>
                    <div className="bg-orange-50 p-3 rounded-lg">
                      <div className="text-2xl font-bold text-orange-600">65cm</div>
                      <div className="text-sm text-gray-600">Vertical Jump</div>
                    </div>
                    <div className="bg-purple-50 p-3 rounded-lg">
                      <div className="text-2xl font-bold text-purple-600">98%</div>
                      <div className="text-sm text-gray-600">AI Confidence</div>
                    </div>
                  </div>
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      <div className="w-2 h-2 bg-green-500 rounded-full animate-pulse"></div>
                      <span className="text-sm text-gray-600">Live Analysis</span>
                    </div>
                    <Badge variant="secondary">
                      <CheckCircle className="w-3 h-3 mr-1" />
                      Verified
                    </Badge>
                  </div>
                </CardContent>
              </Card>
            </div>
          </div>
        </div>
      </section>

      {/* Stats Section */}
      <section className="py-16 bg-gray-50">
        <div className="container mx-auto px-6">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
            {stats.map((stat, index) => (
              <div key={index} className="text-center">
                <div className="mx-auto w-12 h-12 bg-gradient-to-br from-blue-600 to-orange-600 rounded-lg flex items-center justify-center mb-4">
                  <stat.icon className="w-6 h-6 text-white" />
                </div>
                <div className="text-3xl font-bold text-gray-900 mb-2">{stat.number}</div>
                <div className="text-gray-600">{stat.label}</div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className="py-20">
        <div className="container mx-auto px-6">
          <div className="text-center mb-16">
            <h2 className="text-4xl font-bold text-gray-900 mb-4">
              Innovation Meets Human Performance
            </h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              NSTA's advanced patent-pending, scientifically validated algorithms redefine the landscape of movement analysis by harnessing the power of advanced computer vision.
            </p>
          </div>
          
          <div className="grid lg:grid-cols-2 gap-12 items-center">
            <div className="space-y-6">
              {features.map((feature, index) => (
                <Card 
                  key={index}
                  className={`cursor-pointer transition-all duration-300 ${
                    activeFeature === index 
                      ? 'border-blue-500 shadow-lg bg-blue-50' 
                      : 'hover:shadow-md'
                  }`}
                  onClick={() => setActiveFeature(index)}
                >
                  <CardContent className="p-6">
                    <div className="flex items-start gap-4">
                      <div className={`w-12 h-12 rounded-lg flex items-center justify-center ${
                        activeFeature === index 
                          ? 'bg-blue-600 text-white' 
                          : 'bg-gray-100 text-gray-600'
                      }`}>
                        <feature.icon className="w-6 h-6" />
                      </div>
                      <div className="flex-1">
                        <h3 className="text-lg font-semibold text-gray-900 mb-2">
                          {feature.title}
                        </h3>
                        <p className="text-gray-600">
                          {feature.description}
                        </p>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
            
            <div className="lg:pl-8">
              <Card className="bg-gradient-to-br from-blue-50 to-orange-50 border-0 shadow-xl">
                <CardContent className="p-8">
                  <div className="flex items-center gap-3 mb-6">
                    {/* @ts-ignore */}
                    {/* The error is because `features[activeFeature].icon` is a component, not a direct element. */}
                    {/* It needs to be rendered as a component, not as a property of features. */}
                    {/* This is a temporary fix, ideally, `icon` should be a React component type. */}
                    {(() => {
                      const IconComponent = features[activeFeature].icon;
                      return <IconComponent className="w-8 h-8 text-blue-600" />;
                    })()}
                    <h3 className="text-2xl font-bold text-gray-900">
                      {features[activeFeature].title}
                    </h3>
                  </div>
                  <p className="text-lg text-gray-700 leading-relaxed">
                    {features[activeFeature].details}
                  </p>
                </CardContent>
              </Card>
            </div>
          </div>
        </div>
      </section>

      {/* Testimonials Section */}
      <section id="testimonials" className="py-20 bg-gray-50">
        <div className="container mx-auto px-6">
          <div className="text-center mb-16">
            <h2 className="text-4xl font-bold text-gray-900 mb-4">
              Trusted by the Best
            </h2>
            <p className="text-xl text-gray-600">
              Leading coaches and sports professionals rely on NSTA for talent identification
            </p>
          </div>
          
          <div className="grid md:grid-cols-3 gap-8">
            {testimonials.map((testimonial, index) => (
              <Card key={index} className="bg-white border-0 shadow-lg">
                <CardContent className="p-6">
                  <div className="flex items-center gap-1 mb-4">
                    {[...Array(5)].map((_, i) => (
                      <Star key={i} className="w-4 h-4 fill-yellow-400 text-yellow-400" />
                    ))}
                  </div>
                  <p className="text-gray-700 mb-6 italic">
                    "{testimonial.content}"
                  </p>
                  <div className="flex items-center gap-3">
                    <div className="w-12 h-12 bg-gradient-to-br from-blue-600 to-orange-600 rounded-full flex items-center justify-center text-white font-bold">
                      {testimonial.avatar}
                    </div>
                    <div>
                      <div className="font-semibold text-gray-900">{testimonial.name}</div>
                      <div className="text-sm text-gray-600">{testimonial.role}</div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section id="demo" className="py-20 bg-gradient-to-r from-blue-600 to-blue-700">
        <div className="container mx-auto px-6 text-center">
          <h2 className="text-4xl font-bold text-white mb-4">
            Ready to Transform Athletic Assessment?
          </h2>
          <p className="text-xl text-blue-100 mb-8 max-w-2xl mx-auto">
            Join the future of sports talent identification with AI-powered precision and government-grade security.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Button 
              size="lg"
              onClick={() => navigate('/login')}
              className="bg-white text-blue-600 hover:bg-gray-100 text-lg px-8 py-6"
            >
              Access Admin Portal
              <Shield className="ml-2 w-5 h-5" />
            </Button>
            <Button 
              variant="outline" 
              size="lg"
              className="border-white text-white hover:bg-white hover:text-blue-600 text-lg px-8 py-6"
            >
              Schedule Demo
              <ArrowRight className="ml-2 w-5 h-5" />
            </Button>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer id="contact" className="py-12 bg-gray-900">
        <div className="container mx-auto px-6">
          <div className="grid md:grid-cols-4 gap-8">
            <div>
              <div className="flex items-center space-x-3 mb-4">
                <div className="w-8 h-8 rounded-lg flex items-center justify-center bg-white">
                  <img
                    src="/logo.png"
                    alt="NSTA Logo"
                    className="w-6 h-6 object-contain"
                  />
                </div>
                <span className="text-white font-bold text-lg">NSTA</span>
              </div>
              <p className="text-gray-400 text-sm">
                National Sports Talent Assessment<br />
                Sports Authority of India
              </p>
            </div>
            
            <div>
              <h3 className="text-white font-semibold mb-4">Platform</h3>
              <ul className="space-y-2">
                <li><a href="#features" className="text-gray-400 hover:text-white transition-colors">Features</a></li>
                <li><a href="#technology" className="text-gray-400 hover:text-white transition-colors">Technology</a></li>
                <li><a href="#" className="text-gray-400 hover:text-white transition-colors">Security</a></li>
                <li><a href="#" className="text-gray-400 hover:text-white transition-colors">Documentation</a></li>
              </ul>
            </div>
            
            <div>
              <h3 className="text-white font-semibold mb-4">Support</h3>
              <ul className="space-y-2">
                <li><a href="#" className="text-gray-400 hover:text-white transition-colors">Help Center</a></li>
                <li><a href="#" className="text-gray-400 hover:text-white transition-colors">Training</a></li>
                <li><a href="#contact" className="text-gray-400 hover:text-white transition-colors">Contact</a></li>
                <li><a href="#" className="text-gray-400 hover:text-white transition-colors">Status</a></li>
              </ul>
            </div>
            
            <div>
              <h3 className="text-white font-semibold mb-4">Contact</h3>
              <ul className="space-y-2">
                <li className="text-gray-400 text-sm">Sports Authority of India</li>
                <li className="text-gray-400 text-sm">New Delhi, India</li>
                <li><a href="mailto:contact@nsta.gov.in" className="text-gray-400 hover:text-white transition-colors text-sm">contact@nsta.gov.in</a></li>
                <li><a href="tel:+911234567890" className="text-gray-400 hover:text-white transition-colors text-sm">+91 123 456 7890</a></li>
              </ul>
            </div>
          </div>
          
          <div className="border-t border-gray-800 mt-8 pt-8 flex flex-col md:flex-row justify-between items-center">
            <p className="text-gray-400 text-sm">
              © 2024 Sports Authority of India. All rights reserved.
            </p>
            <div className="flex space-x-6 mt-4 md:mt-0">
              <a href="#" className="text-gray-400 hover:text-white text-sm">Privacy Policy</a>
              <a href="#" className="text-gray-400 hover:text-white text-sm">Terms of Service</a>
              <a href="#" className="text-gray-400 hover:text-white text-sm">Cookies</a>
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default LandingPage;
