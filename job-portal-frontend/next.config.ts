import type { NextConfig } from 'next';

const nextConfig: NextConfig = {
  reactStrictMode: true,
  poweredByHeader: false,
  compress: true,
  typedRoutes: true,
  experimental: {
    optimizePackageImports: ['@tanstack/react-query', 'zustand', 'lucide-react', 'zod', 'clsx'],
  },
  images: {
    remotePatterns: [{ protocol: 'https', hostname: '**' }],
  },
  allowedDevOrigins: ['http://localhost:3000', 'http://192.168.100.2:3000'],

  eslint: {
    ignoreDuringBuilds: true,
  },
};

export default nextConfig;
