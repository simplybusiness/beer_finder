import React from 'react'
import PostcodesIO from 'postcodesio-client'
import geolib from 'geolib'
import _ from 'lodash'
import Outlets from './outlets'

export default class Finder extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      outlets: this.props.outlets,
      postcode: ''
    };
  }

  lookUpPostcode(postcode) {
    const postcodes = new PostcodesIO();
    postcodes.lookup(postcode).then(postcode => {
      this.sortByDistance(postcode.latitude, postcode.longitude);
    });
  }

  sortByDistance(lat, long) {
    const newOutlets = this.state.outlets.map(outlet => {
      let distance = geolib.getDistance(
        {latitude: outlet.lat, longitude: outlet.long},
        {latitude: lat, longitude: long}
      ) * 0.00062137
      return {
        ...outlet,
        distance: distance.toFixed(2),
        distanceUnits: 'Miles'
      }
    })
    this.setState({outlets: _.sortBy(newOutlets, 'distance')})
  }

  onChange = (event) => {
    this.setState({ postcode: event.target.value });
  }

  onSubmit = (event) => {
    event.preventDefault();
    this.lookUpPostcode(this.state.postcode);
  }

  renderForm() {
    return (
      <form onSubmit={this.onSubmit}>
        <div className="form-row">
          <div className="col-auto">
            <input
              type="text"
              name="postcode"
              id="postcode"
              placeholder="Postcode"
              className="form-control mb-2"
              value={this.state.postcode}
              onChange={this.onChange}
            />
          </div>
          <div className="col-auto">
            <input type="submit" name="commit" value="Go" className="btn btn-primary mb-2"/>
          </div>
        </div>
      </form>
    );
  }

  render () {
    return (
      <div>
        {this.renderForm()}
        <Outlets outlets={this.state.outlets}/>
      </div>
    );
  }
}
