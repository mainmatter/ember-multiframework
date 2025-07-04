import { createContext } from 'react';

export const ApplicationContext = createContext(null);

export function ApplicationProvider({ owner, children }) {
  return (
    <ApplicationContext.Provider value={owner}>
      {children}
    </ApplicationContext.Provider>
  );
}
