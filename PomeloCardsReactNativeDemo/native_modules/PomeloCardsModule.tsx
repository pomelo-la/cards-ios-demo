/**
 * This exposes the native PomeloCardsModule module as a JS module. This has a
 * function 'launchCards' which takes the following parameters:
 *
 * 1. String email: User email
 * 2. Promise resolve: A Promise called if the launch succeed 
 * 3. Promise resolve: A Promise called if the launch failed 
 */
import {NativeModules} from 'react-native';
const {PomeloCardsModule} = NativeModules;
interface PomeloCardsInterface {
    setupSDK(email: string): void;
    launchCardListWidget(cardId: string, resolve: Promise<void>, reject: Promise<void>): void;
    launchChangePinWidget(cardId: string, resolve: Promise<void>, reject: Promise<void>): void;
    launchActivateCardWidget(resolve: Promise<void>, reject: Promise<void>): void;
}
export default PomeloCardsModule as PomeloCardsInterface;