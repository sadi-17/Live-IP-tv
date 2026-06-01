export interface ServerModel {
  id: string;
  name: string;
  url: string;
  icon: string;
  description: string;
}

export const defaultServers: ServerModel[] = [
  {
    id: '1',
    name: 'Stadium 1 - Live Feed',
    url: 'http://10.2.2.10',
    icon: '⚽',
    description: 'Main match streaming',
  },
  {
    id: '2',
    name: 'Stadium 2 - Championship',
    url: 'http://172.17.50.112',
    icon: '🏆',
    description: 'Championship matches',
  },
  {
    id: '3',
    name: 'World Cup - Global Feed',
    url: 'http://192.168.91.8',
    icon: '🌍',
    description: 'International broadcasts',
  },
];
