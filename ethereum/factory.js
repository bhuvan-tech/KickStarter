import web3 from './web3';
import CampaignFactory from './build/CampaignFactory.json';

const instance = new web3.eth.Contract(
    JSON.parse(CampaignFactory.interface),
    '0x27d81BcFF791AAdc5d9eAD757f3612943Fc2709b'
);

export default instance;
