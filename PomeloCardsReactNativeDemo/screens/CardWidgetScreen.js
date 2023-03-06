import React, { useRef } from 'react'
import ReactNative, { Button, SafeAreaView, StyleSheet } from 'react-native';
import PomeloCardWidgetViewManager, { PomeloCardView } from '../native_modules/PomeloCardWidgetViewManager';

const CardWidgetScreen = () => {
    const cardViewRef = useRef(null)

    function showSensitiveData() {
      const tag = ReactNative.findNodeHandle(cardViewRef.current)
      PomeloCardWidgetViewManager.showSensitiveData(tag, "crd-2LQY6Jrh6ScnBaJT7JHcX36ecQG")
      .then(res => {
          // Sensitive data load successfully
       })
      .catch(e => { alert(`Show sensitive data failed with error: ${e.toString()}`) })
    }

    return (
        <SafeAreaView style={styles.container}>
            <PomeloCardView 
                style={styles.card}
                ref={cardViewRef}
                setupParams={{cardholderName:"Juan Perez", lastFourCardDigits:"8016"}}
                />
              <Button
                onPress={() => showSensitiveData()}
                title="Display sensitive data"
                />
        </SafeAreaView>
    );
};

export default CardWidgetScreen;


const styles = StyleSheet.create({
  container: {
      flex: 1
  },
  card: {
    flex: 1,
    margin: 10,
    backgroundColor: 'transparent',
  }
});