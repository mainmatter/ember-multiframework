import { StrictMode } from 'react';
import { ApplicationProvider } from './application-context.jsx';

export function App({ children, owner, providerOptions }) {
  return (
    <StrictMode>
      <ApplicationProvider owner={owner}>
        <CustomProviders providerOptions={providerOptions}>
          {children}
        </CustomProviders>
      </ApplicationProvider>
    </StrictMode>
  );
}

function CustomProviders({ children, providerOptions }) {
  if (!providerOptions?.component) {
    return <>{children}</>;
  }

  const { component: Component, props = {} } = providerOptions;
  return <Component {...props}>{children}</Component>;
}
