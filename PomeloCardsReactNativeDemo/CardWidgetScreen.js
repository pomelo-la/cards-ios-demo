import React, { useRef } from 'react'
import { Button, SafeAreaView } from 'react-native';
import PomeloCardView from './native_modules/PomeloCardWidgetViewManager';



const createNativePomeloCardView = async (params) => {
    try {
      const cardView = await NativePomeloCardWidgetViewManager.createCustomView(params);
      return cardView;
    } catch (error) {
      console.error(error);
    }
  };

const CardWidgetScreen = ({ navigation }) => {
    const cardViewRef = useRef(null)

    function getSensitiveData() {
        // console.log(cardViewRef.current)
        cardViewRef.current.getSensitiveData("Juan Perez", "1212")
    }

    return (
        <SafeAreaView style={{ flex: 1 }}>
            <PomeloCardView 
              ref={cardViewRef}
              setupParams={{cardholderName:"Juan Perez", lastFourCardDigits:"1212"}}/>
            <Button
                onPress={() => getSensitiveData()}
                title="Get sensitive data"
                />
        </SafeAreaView>
    );
};

export default CardWidgetScreen;