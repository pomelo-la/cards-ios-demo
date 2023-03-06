
import React from 'react';
import { SafeAreaView, StyleSheet, StatusBar, View, SectionList, TouchableOpacity, Text } from 'react-native';
import NativePomeloCardsModule from '../native_modules/PomeloCardsModule';

const DATA = [
    {
        title: 'SDK',
        data: [{
            id: 'cards-sdk',
            title: 'Cards',
        }]
    },
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

const HomeScreen = ({ navigation }) => {
    function launchCards() {
        NativePomeloCardsModule.launchCards()
            .then(res => { })
            .catch(e => {
                alert("Launch Card Failed")
            })
    }

    function onPressItem(item) {
        if (item.id == 'cards-sdk') {
            launchCards()
        } else {
            navigation.navigate('CardWidget')
            console.log(item)
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


const styles = StyleSheet.create({
    container: {
        flex: 1,
        marginTop: StatusBar.currentHeight || 0,
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