import React, { useRef } from 'react'
import ReactNative, { Button, SafeAreaView } from 'react-native';
import PomeloCardWidgetViewManager, { PomeloCardView } from '../native_modules/PomeloCardWidgetViewManager';

const CardWidgetScreen = ({ navigation }) => {
    const cardViewRef = useRef(null)

    function showSensitiveData() {
      const tag = ReactNative.findNodeHandle(cardViewRef.current)
      
      PomeloCardWidgetViewManager.showSensitiveData(tag, "crd-2LQY6Jrh6ScnBaJT7JHcX36ecQG").then(res => { })
      .catch(e => {
          alert("Launch Card Failed")
      })
    }

    return (
        <SafeAreaView style={{ flex: 1 }}>
            <PomeloCardView 
              ref={cardViewRef}
              setupParams={{cardholderName:"Juan Perez", lastFourCardDigits:"8016"}}/>
            <Button
                onPress={() => showSensitiveData()}
                title="Display sensitive data"
                />
        </SafeAreaView>
    );
};

export default CardWidgetScreen;