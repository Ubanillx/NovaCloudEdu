import React, { createContext, useContext, useState } from 'react';

interface SiderContextType {
  siderHidden: boolean;
  setSiderHidden: (hidden: boolean) => void;
  siderCollapsed: boolean;
  setSiderCollapsed: (collapsed: boolean) => void;
}

const SiderContext = createContext<SiderContextType>({
  siderHidden: false,
  setSiderHidden: () => {},
  siderCollapsed: false,
  setSiderCollapsed: () => {},
});

export const useSider = () => useContext(SiderContext);

export const SiderProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [siderHidden, setSiderHidden] = useState(false);
  const [siderCollapsed, setSiderCollapsed] = useState(false);
  return (
    <SiderContext.Provider value={{ siderHidden, setSiderHidden, siderCollapsed, setSiderCollapsed }}>
      {children}
    </SiderContext.Provider>
  );
};
