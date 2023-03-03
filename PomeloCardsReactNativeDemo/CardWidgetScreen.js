import React, { useRef } from 'react'
import ReactNative, { Button, SafeAreaView, UIManager } from 'react-native';
import PomeloCardView from './native_modules/PomeloCardWidgetViewManager';

const CardWidgetScreen = ({ navigation }) => {
    const cardViewRef = useRef(null)

    function showSensitiveData() {
      UIManager.dispatchViewManagerCommand(
        ReactNative.findNodeHandle(cardViewRef.current),
        UIManager.getViewManagerConfig('PomeloCardWidgetView').Commands.showSensitiveData,
        ["crd-2LQY6Jrh6ScnBaJT7JHcX36ecQG"],
      );
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