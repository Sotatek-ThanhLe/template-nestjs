import { BigNumber } from '@0x/utils';
import { ONE_SECOND_MS, TEN_MINUTES_MS } from 'src/shares/constants/constant';

export const getRandomFutureDateInSeconds = (): BigNumber => {
  return new BigNumber(Date.now() + TEN_MINUTES_MS).div(ONE_SECOND_MS).integerValue(BigNumber.ROUND_CEIL);
};

export const genRandomSixDigit = (): number => {
  return Math.floor(100000 + Math.random() * 900000);
};

export function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

export function divMod(numerator: string, denominator: string): BigNumber {
  return new BigNumber(new BigNumber(numerator).div(denominator).plus(new BigNumber(denominator).mod(denominator)));
}
