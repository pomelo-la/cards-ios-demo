
import React from 'react';
import { SafeAreaView, StyleSheet, View, SectionList, TouchableOpacity, Text } from 'react-native';
import NativePomeloCardsModule from '../pomelo_native_modules/PomeloCardsModule';
import * as constants from './constants'

const HomeScreen = ({ navigation }) => {
    function launchCardListWidget() {
        NativePomeloCardsModule.launchCardListWidget(constants.cardId).then(res => {
            // Sensitive data load successfully
         })
        .catch(e => { alert(`Show sensitive data failed with error: ${e.toString()}`) })
    }

    function launcChangePinWidget() {
        NativePomeloCardsModule.launchChangePinWidget(constants.cardId).then(res => {
            // Sensitive changed pin
         })
        .catch(e => { alert(`Change pin failed with error: ${e.toString()}`) })
    }

    function launchActivateCardWidget() {
        NativePomeloCardsModule.launchActivateCardWidget().then(res => {
            // Activate card succeed
         })
        .catch(e => { alert(`Change pin failed with error: ${e.toString()}`) })
    }

    function onPressItem(item) {
        if (item.id == 'widget-card') {
            navigation.navigate('CardWidget')
        } else if (item.id == 'widget-card-list') {
            launchCardListWidget()
        } else if (item.id == 'widget-change-pin') {
            launcChangePinWidget()
        } else if (item.id == 'widget-activate-card') {
            launchActivateCardWidget()
        } else {
            alert(`Flow not supported for item: ${item.title}`)
        }
    }

    const Item = ({ item }) => (
        <TouchableOpacity onPress={() => onPressItem(item)}>
            <View style={styles.item}>
                <Text style={styles.title}>{item.title}</Text>
            </View>
        </TouchableOpacity>
    );

    return (
        <SafeAreaView style={styles.container}>
            <SectionList
                sections={DATA}
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => <Item item={item} />}
                renderSectionHeader={({ section: { title } }) => (
                    <Text style={styles.header}>{title}</Text>
                )}
            />
        </SafeAreaView>
    );
};

const DATA = [
    {
        title: 'Widgets',
        data: [
            {
                id: 'widget-card',
                title: 'Card',
            },
            {
                id: 'widget-card-list',
                title: 'Card list',
            },
            {
                id: 'widget-change-pin',
                title: 'Change Pin',
            },
            {
                id: 'widget-activate-card',
                title: 'Activate Card',
            }
        ]
    }
];

const styles = StyleSheet.create({
    container: {
        flex: 1
    },
    item: {
        padding: 10,
        fontSize: 18,
        height: 44,
    },
    header: {
        paddingTop: 2,
        paddingLeft: 10,
        paddingRight: 10,
        paddingBottom: 2,
        fontSize: 14,
        fontWeight: 'bold',
        backgroundColor: 'rgba(247,247,247,1.0)',
    },
    title: {
        fontSize: 16,
    },
});



export default HomeScreen;