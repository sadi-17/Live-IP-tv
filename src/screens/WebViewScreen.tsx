import React, {useRef, useState} from 'react';
import {
  ActivityIndicator,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from 'react-native';
import {WebView} from 'react-native-webview';
import type {NativeStackScreenProps} from '@react-navigation/native-stack';
import type {RootStackParamList} from '../types';
import {AppConstants} from '../utils/constants';

type Props = NativeStackScreenProps<RootStackParamList, 'WebView'>;

const C = AppConstants.colors;

export default function WebViewScreen({route, navigation}: Props) {
  const {url, name} = route.params;
  const webviewRef = useRef<WebView>(null);
  const [progress, setProgress] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <TouchableOpacity style={styles.backBtn} onPress={() => navigation.goBack()}>
          <Text style={styles.backIcon}>←</Text>
        </TouchableOpacity>
        <Text style={styles.headerTitle} numberOfLines={1}>{name}</Text>
        <TouchableOpacity
          style={styles.reloadBtn}
          onPress={() => {
            setError(null);
            webviewRef.current?.reload();
          }}>
          <Text style={styles.reloadIcon}>↻</Text>
        </TouchableOpacity>
      </View>

      {/* Progress bar */}
      {loading && (
        <View style={styles.progressTrack}>
          <View style={[styles.progressBar, {width: `${Math.round(progress * 100)}%`}]} />
        </View>
      )}

      {/* WebView */}
      {error ? (
        <View style={styles.errorContainer}>
          <Text style={styles.errorIcon}>⚠️</Text>
          <Text style={styles.errorTitle}>Connection Error</Text>
          <Text style={styles.errorMsg}>{error}</Text>
          <TouchableOpacity
            style={styles.retryBtn}
            onPress={() => {
              setError(null);
              webviewRef.current?.reload();
            }}>
            <Text style={styles.retryText}>↻  Retry</Text>
          </TouchableOpacity>
        </View>
      ) : (
        <WebView
          ref={webviewRef}
          source={{uri: url}}
          style={styles.webview}
          javaScriptEnabled
          domStorageEnabled
          allowsInlineMediaPlayback
          mediaPlaybackRequiresUserAction={false}
          mixedContentMode="always"
          onLoadProgress={({nativeEvent}) => setProgress(nativeEvent.progress)}
          onLoadStart={() => {
            setLoading(true);
            setError(null);
          }}
          onLoadEnd={() => setLoading(false)}
          onError={({nativeEvent}) =>
            setError(nativeEvent.description || 'Failed to load page')
          }
          renderLoading={() => (
            <ActivityIndicator
              style={styles.spinner}
              size="large"
              color={C.accent}
            />
          )}
        />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {flex: 1, backgroundColor: C.background},
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: C.primary,
    paddingTop: 44,
    paddingBottom: 12,
    paddingHorizontal: 12,
    elevation: 4,
  },
  backBtn: {padding: 8},
  backIcon: {fontSize: 22, color: C.accent, fontWeight: 'bold'},
  headerTitle: {flex: 1, fontSize: 16, fontWeight: 'bold', color: C.accent, marginHorizontal: 8},
  reloadBtn: {padding: 8},
  reloadIcon: {fontSize: 22, color: C.accent, fontWeight: 'bold'},
  progressTrack: {height: 3, backgroundColor: C.card},
  progressBar: {height: 3, backgroundColor: C.accent},
  webview: {flex: 1, backgroundColor: C.background},
  spinner: {position: 'absolute', top: 0, left: 0, right: 0, bottom: 0},
  errorContainer: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 32,
  },
  errorIcon: {fontSize: 56, marginBottom: 16},
  errorTitle: {fontSize: 20, fontWeight: 'bold', color: '#EF5350', marginBottom: 8},
  errorMsg: {fontSize: 14, color: C.accent, textAlign: 'center', marginBottom: 24},
  retryBtn: {
    backgroundColor: C.accent,
    borderRadius: 12,
    paddingHorizontal: 28,
    paddingVertical: 12,
  },
  retryText: {color: C.primary, fontWeight: 'bold', fontSize: 15},
});
