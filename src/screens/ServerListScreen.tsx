import React, {useState} from 'react';
import {
  Alert,
  FlatList,
  Modal,
  Pressable,
  StyleSheet,
  Text,
  TextInput,
  TouchableOpacity,
  View,
} from 'react-native';
import type {NativeStackScreenProps} from '@react-navigation/native-stack';
import type {RootStackParamList} from '../types';
import {AppConstants} from '../utils/constants';
import {defaultServers, type ServerModel} from '../models/ServerModel';

type Props = NativeStackScreenProps<RootStackParamList, 'ServerList'>;

export default function ServerListScreen({navigation}: Props) {
  const [servers, setServers] = useState<ServerModel[]>(defaultServers);
  const [modalVisible, setModalVisible] = useState(false);
  const [newName, setNewName] = useState('');
  const [newUrl, setNewUrl] = useState('');

  function addServer() {
    if (!newName.trim() || !newUrl.trim()) {
      Alert.alert('Missing fields', 'Please fill in both name and URL.');
      return;
    }
    setServers(prev => [
      ...prev,
      {
        id: Date.now().toString(),
        name: newName.trim(),
        url: newUrl.trim(),
        icon: '📡',
        description: '',
      },
    ]);
    setNewName('');
    setNewUrl('');
    setModalVisible(false);
  }

  function renderItem({item, index}: {item: ServerModel; index: number}) {
    return (
      <TouchableOpacity
        style={styles.card}
        activeOpacity={0.75}
        onPress={() => navigation.navigate('WebView', {url: item.url, name: item.name})}>
        <View style={styles.iconBox}>
          <Text style={styles.cardIcon}>{item.icon}</Text>
        </View>
        <View style={styles.cardInfo}>
          <Text style={styles.cardName}>{item.name}</Text>
          <Text style={styles.cardUrl} numberOfLines={1}>{item.url}</Text>
          {!!item.description && (
            <Text style={styles.cardDesc} numberOfLines={1}>{item.description}</Text>
          )}
        </View>
        <View style={styles.watchBadge}>
          <Text style={styles.watchIcon}>⚽</Text>
          <Text style={styles.watchText}>Watch</Text>
        </View>
      </TouchableOpacity>
    );
  }

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>⚽ Stadium Streams</Text>
      </View>

      {/* List */}
      {servers.length === 0 ? (
        <View style={styles.empty}>
          <Text style={styles.emptyIcon}>📺</Text>
          <Text style={styles.emptyText}>No servers added</Text>
        </View>
      ) : (
        <FlatList
          data={servers}
          keyExtractor={item => item.id}
          renderItem={renderItem}
          contentContainerStyle={styles.list}
        />
      )}

      {/* FAB */}
      <TouchableOpacity style={styles.fab} onPress={() => setModalVisible(true)}>
        <Text style={styles.fabText}>+ Add Stadium</Text>
      </TouchableOpacity>

      {/* Add Server Modal */}
      <Modal
        visible={modalVisible}
        transparent
        animationType="fade"
        onRequestClose={() => setModalVisible(false)}>
        <Pressable style={styles.overlay} onPress={() => setModalVisible(false)}>
          <Pressable style={styles.modal} onPress={e => e.stopPropagation()}>
            <Text style={styles.modalTitle}>⚽ Add New Stadium</Text>

            <Text style={styles.inputLabel}>Stadium Name</Text>
            <TextInput
              style={styles.input}
              placeholder="My Stadium"
              placeholderTextColor="rgba(255,215,0,0.4)"
              value={newName}
              onChangeText={setNewName}
            />

            <Text style={styles.inputLabel}>Server URL</Text>
            <TextInput
              style={styles.input}
              placeholder="http://192.168.1.100"
              placeholderTextColor="rgba(255,215,0,0.4)"
              value={newUrl}
              onChangeText={setNewUrl}
              autoCapitalize="none"
              keyboardType="url"
            />

            <View style={styles.modalButtons}>
              <TouchableOpacity
                style={styles.cancelBtn}
                onPress={() => setModalVisible(false)}>
                <Text style={styles.cancelBtnText}>Cancel</Text>
              </TouchableOpacity>
              <TouchableOpacity style={styles.addBtn} onPress={addServer}>
                <Text style={styles.addBtnText}>Add Stadium</Text>
              </TouchableOpacity>
            </View>
          </Pressable>
        </Pressable>
      </Modal>
    </View>
  );
}

const C = AppConstants.colors;

const styles = StyleSheet.create({
  container: {flex: 1, backgroundColor: C.background},
  header: {
    backgroundColor: C.primary,
    paddingTop: 48,
    paddingBottom: 16,
    paddingHorizontal: 20,
    elevation: 4,
  },
  headerTitle: {
    fontSize: 22,
    fontWeight: 'bold',
    color: C.accent,
    textAlign: 'center',
  },
  list: {padding: 16, paddingBottom: 100},
  card: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: C.card,
    borderRadius: 16,
    padding: 16,
    marginBottom: 14,
    elevation: 4,
  },
  iconBox: {
    width: 56,
    height: 56,
    borderRadius: 14,
    backgroundColor: C.primary,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 14,
  },
  cardIcon: {fontSize: 26},
  cardInfo: {flex: 1},
  cardName: {fontSize: 16, fontWeight: 'bold', color: C.text, marginBottom: 3},
  cardUrl: {fontSize: 13, color: C.subtext, fontFamily: 'monospace'},
  cardDesc: {fontSize: 12, color: C.subtext, marginTop: 2},
  watchBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: C.accent,
    borderRadius: 20,
    paddingHorizontal: 12,
    paddingVertical: 6,
    gap: 4,
  },
  watchIcon: {fontSize: 14},
  watchText: {fontSize: 12, fontWeight: 'bold', color: C.primary},
  empty: {flex: 1, alignItems: 'center', justifyContent: 'center'},
  emptyIcon: {fontSize: 64, marginBottom: 12},
  emptyText: {fontSize: 18, color: C.subtext},
  fab: {
    position: 'absolute',
    bottom: 24,
    right: 24,
    backgroundColor: C.accent,
    borderRadius: 28,
    paddingHorizontal: 20,
    paddingVertical: 14,
    elevation: 6,
  },
  fabText: {fontWeight: 'bold', color: C.primary, fontSize: 15},
  overlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.6)',
    justifyContent: 'center',
    padding: 24,
  },
  modal: {
    backgroundColor: C.primary,
    borderRadius: 20,
    padding: 24,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: C.accent,
    marginBottom: 20,
    textAlign: 'center',
  },
  inputLabel: {fontSize: 13, color: C.accent, marginBottom: 6, fontWeight: '600'},
  input: {
    borderWidth: 1,
    borderColor: C.accent,
    borderRadius: 12,
    padding: 12,
    color: C.accent,
    backgroundColor: C.background,
    marginBottom: 16,
    fontSize: 14,
  },
  modalButtons: {flexDirection: 'row', gap: 12, marginTop: 4},
  cancelBtn: {
    flex: 1,
    padding: 12,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: C.accent,
    alignItems: 'center',
  },
  cancelBtnText: {color: C.accent, fontWeight: '600'},
  addBtn: {
    flex: 1,
    padding: 12,
    borderRadius: 12,
    backgroundColor: C.accent,
    alignItems: 'center',
  },
  addBtnText: {color: C.primary, fontWeight: 'bold'},
});
