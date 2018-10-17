import React from 'react'
import moment from 'moment'

const StockItems = ({items}) => {
  return items.map(item => {
    return (
      <li className="list-group-item d-flex justify-content-between align-items-center" key={item.id}>
        <div><span><img src={item.icon_image} width="24" height="24"/></span> {item.name}</div>
        <small>{moment(item.delivery_date).fromNow()}</small>
      </li>
    );
  });
}

export default StockItems
