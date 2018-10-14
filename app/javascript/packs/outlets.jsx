import React from 'react'
import moment from 'moment'

export default class Outlets extends React.Component {

  renderStockItems(items) {
    return items.map(item => {
      return (
        <li className="list-group-item d-flex justify-content-between align-items-center" key={item.id}>
          <div><span><img src={item.icon_image} width="24" height="24"/></span> {item.name}</div>
          <small>{moment(item.delivery_date).fromNow()}</small>
        </li>
      );
    });
  }

  render () {
    return this.props.outlets.map(outlet => {
      return (
        <div className="card" key={outlet.id}>
          <div className="card-body">
            <div className="container">
              <div className="row">
                <div className="col-sm">
                  <h4 className="card-title">{outlet.name} <small>{outlet.outlet_type}</small></h4>
                  <h6 className="card-subtitle mb-2">{outlet.address}, {outlet.postcode}</h6>
                  <div>{outlet.distance} {outlet.distance_units} </div>
                </div>
                <div className="col-sm">
                  <div className="card-text">
                    <div className="card-text">
                      <ul className="list-group">
                        {this.renderStockItems(outlet.stock_items)}
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      )
    });
  }
}
