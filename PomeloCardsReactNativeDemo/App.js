/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */
import React from 'react';
import { Button, SafeAreaView, NativeModules } from 'react-native';

const App = () => {
  function launchCards() {
    NativeModules.PomeloCardsAdapter.launchCards()
    .then(res => {})
    .catch(e => {
      alert("Launch Card Failed")
    }) 
  }

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <Button
        title = "Launch Cards"
        onPress = {() => 
          launchCards()
        }
      />
    </SafeAreaView>
  );
};

export default App;