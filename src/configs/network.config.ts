import { getConfig } from 'src/configs/index';

export const TX_DEFAULTS = { gas: 2000000, gasPrice: 1000000000 };
export const MNEMONIC = getConfig().get<string>('mnemonic');
export const BASE_DERIVATION_PATH = getConfig().get<string>('base_derivation_path');

export interface NetworkSpecificConfigs {
  rpcUrl: string;
  networkId: number;
  chainId: number;
}

export interface Stellar {
  url: string;
}

export interface BSC {
  url: string;
}

export const NETWORK_CONFIGS: NetworkSpecificConfigs = {
  rpcUrl: getConfig().get<string>('rpc_url'),
  networkId: getConfig().get<number>('network_id'),
  chainId: getConfig().get<number>('chain_id'),
};

export const STELLAR_HORIZON: Stellar = {
  url: getConfig().get<string>('stellar_url'),
};
