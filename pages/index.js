import React, {Component} from 'react';
import factory from '../ethereum/factory';
import {Button, Card} from 'semantic-ui-react';
// import Layout from '../components/Layout'
// import {Link} from '../routes';

class CampaignIndex extends Component {
    static async getInitialProps() {
        const campaigns = await factory.methods.getDeployedCampaigns().call();
        return {campaigns};
    }

    renderCampaigns() {
        const items = this.props.campaigns.map(x => {
            return {
                header: address,
                description: <a>View Campaign</a>,
                fluid: true
            }
        });
        return <Card.Group items={items}/>;
    }

    render(){
      return <div>{this.renderCampaigns()}</div>
  }

}

//NEXT.js server side rendering