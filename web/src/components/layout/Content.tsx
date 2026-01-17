import React, { type ReactNode } from 'react';

interface ContentProps {
  children: ReactNode;
  className?: string;
}

export const Content: React.FC<ContentProps> = ({ children, className = '' }) => {
  return (
    <main className={`flex-1 p-4 md:p-6 lg:p-8 max-w-7xl mx-auto w-full ${className}`}>
      {children}
    </main>
  );
};
