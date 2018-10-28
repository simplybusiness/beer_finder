import React from 'react'
import StockItems from './stockitems'

const Outlets =({outlets}) => outlets.map(outlet => (
  <div className="card" key={outlet.id}>
    <div className="card-body">
      <div className="container">
        <div className="row">
          <div className="col-sm">
            <h4 className="card-title">{outlet.name} <small>{outlet.outlet_type}</small></h4>
            <h6 className="card-subtitle mb-2">{outlet.address}, {outlet.postcode}</h6>
            <div>{outlet.distance} {outlet.distanceUnits} </div>
          </div>
          <div className="col-sm">
            <div className="card-text">
              <div className="card-text">
                <ul className="list-group">
                  <StockItems items={outlet.stock_items}/>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
)
);

export default Outlets
