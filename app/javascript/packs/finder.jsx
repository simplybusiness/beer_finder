import React from 'react'
import Outlets from './outlets'

export default class Finder extends React.Component {
  render () {
    return (
      <div>
        <Outlets outlets={this.props.outlets}/>
      </div>
    );
  }
}
