import { NativeModules, requireNativeComponent } from 'react-native';
const {PomeloCardWidgetViewManager} = NativeModules;

const PomeloCardView = requireNativeComponent('PomeloCardWidgetView')

interface PomeloCardWidgetModuleInterface {
    showSensitiveData(tag: number, cardId: string, resolve: Promise<void>, reject: Promise<void>): void;
} 

export { PomeloCardView };
export default PomeloCardWidgetViewManager as PomeloCardWidgetModuleInterface;