/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */
import React, { useEffect } from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import HomeScreen from './HomeScreen';
import CardWidgetScreen from './CardWidgetScreen';
import NativePomeloCardsModule from './native_modules/PomeloCardsModule';

const Stack = createNativeStackNavigator();

const App = () => {
  useEffect(() => {
    NativePomeloCardsModule.setupSDK("juan.perez@pomelo.la")
  }, []);
  
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen
          name="Home"
          component={HomeScreen}
          options={{title: 'Home'}}
        />
        <Stack.Screen
          name="CardWidget"
          component={CardWidgetScreen}
          options={{title: 'Card Widget'}}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
};
export default App;