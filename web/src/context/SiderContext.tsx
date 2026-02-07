import React, { createContext, useContext, useState } from 'react';

interface SiderContextType {
  siderHidden: boolean;
  setSiderHidden: (hidden: boolean) => void;
}

const SiderContext = createContext<SiderContextType>({
  siderHidden: false,
  setSiderHidden: () => {},
});

export const useSider = () => useContext(SiderContext);

export const SiderProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [siderHidden, setSiderHidden] = useState(false);
  return (
    <SiderContext.Provider value={{ siderHidden, setSiderHidden }}>
      {children}
    </SiderContext.Provider>
  );
};
