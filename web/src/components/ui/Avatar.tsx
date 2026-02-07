import React from 'react';
import { User, UsersRound } from 'lucide-react';

interface AvatarProps {
  src?: string;
  name?: string;
  size?: 'sm' | 'md' | 'lg' | 'xl';
  icon?: 'user' | 'group';
  className?: string;
}

export const Avatar: React.FC<AvatarProps> = ({ 
  src, 
  name, 
  size = 'md', 
  icon = 'user',
  className = ''
}) => {
  const sizeMap = { 
    sm: 'w-9 h-9 text-sm', 
    md: 'w-11 h-11 text-base', 
    lg: 'w-14 h-14 text-lg',
    xl: 'w-20 h-20 text-2xl'
  };
  
  const iconSizes = {
    sm: 16,
    md: 20,
    lg: 26,
    xl: 32
  };

  const baseClasses = `${sizeMap[size]} rounded-xl shadow-sm ring-2 ring-white dark:ring-gray-800 object-cover ${className}`;

  if (src) {
    return (
      <img
        src={src}
        alt={name || ''}
        className={baseClasses}
      />
    );
  }

  const IconComp = icon === 'group' ? UsersRound : User;
  const initial = name?.[0];

  return (
    <div className={`${baseClasses} bg-gradient-to-br from-brand-100 to-brand-50 dark:from-brand-900/40 dark:to-brand-800/20 text-brand-600 dark:text-brand-400 flex items-center justify-center`}>
      {initial ? (
        <span className="font-semibold">{initial}</span>
      ) : (
        <IconComp size={iconSizes[size]} />
      )}
    </div>
  );
};
