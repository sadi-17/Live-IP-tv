import React, {useEffect, useRef} from 'react';
import {Animated, StyleSheet, Text, View} from 'react-native';
import type {NativeStackScreenProps} from '@react-navigation/native-stack';
import type {RootStackParamList} from '../types';
import {AppConstants} from '../utils/constants';

type Props = NativeStackScreenProps<RootStackParamList, 'Splash'>;

export default function SplashScreen({navigation}: Props) {
  const iconScale = useRef(new Animated.Value(0)).current;
  const iconOpacity = useRef(new Animated.Value(0)).current;
  const titleOpacity = useRef(new Animated.Value(0)).current;
  const subtitleOpacity = useRef(new Animated.Value(0)).current;
  const creditOpacity = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.sequence([
      Animated.parallel([
        Animated.spring(iconScale, {
          toValue: 1,
          tension: 50,
          friction: 4,
          useNativeDriver: true,
        }),
        Animated.timing(iconOpacity, {
          toValue: 1,
          duration: 600,
          useNativeDriver: true,
        }),
      ]),
      Animated.timing(titleOpacity, {
        toValue: 1,
        duration: 500,
        useNativeDriver: true,
      }),
      Animated.timing(subtitleOpacity, {
        toValue: 1,
        duration: 400,
        useNativeDriver: true,
      }),
      Animated.timing(creditOpacity, {
        toValue: 1,
        duration: 400,
        useNativeDriver: true,
      }),
    ]).start();

    const timer = setTimeout(() => {
      navigation.replace('ServerList');
    }, 3000);

    return () => clearTimeout(timer);
  }, [navigation, iconScale, iconOpacity, titleOpacity, subtitleOpacity, creditOpacity]);

  return (
    <View style={styles.container}>
      <View style={styles.center}>
        <Animated.Text
          style={[
            styles.icon,
            {transform: [{scale: iconScale}], opacity: iconOpacity},
          ]}>
          ⚽
        </Animated.Text>

        <Animated.Text style={[styles.title, {opacity: titleOpacity}]}>
          Football World Cup
        </Animated.Text>

        <Animated.Text style={[styles.subtitle, {opacity: subtitleOpacity}]}>
          ⚽ Live Stadium Streams ⚽
        </Animated.Text>
      </View>

      <Animated.View style={[styles.bottom, {opacity: creditOpacity}]}>
        <Text style={styles.developer}>{AppConstants.developer}</Text>
      </Animated.View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: AppConstants.colors.background,
    alignItems: 'center',
    justifyContent: 'center',
  },
  center: {
    alignItems: 'center',
    paddingHorizontal: 24,
  },
  icon: {
    fontSize: 96,
    marginBottom: 24,
  },
  title: {
    fontSize: 36,
    fontWeight: 'bold',
    color: AppConstants.colors.accent,
    textAlign: 'center',
    letterSpacing: 2,
    marginBottom: 12,
  },
  subtitle: {
    fontSize: 16,
    color: 'rgba(255,255,255,0.85)',
    textAlign: 'center',
    letterSpacing: 1,
  },
  bottom: {
    position: 'absolute',
    bottom: 48,
  },
  developer: {
    fontSize: 13,
    color: AppConstants.colors.accent,
    fontWeight: '600',
    letterSpacing: 1,
  },
});
