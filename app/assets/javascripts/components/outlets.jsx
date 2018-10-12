class Outlets extends React.Component {

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
              </div>
            </div>
          </div>
        </div>
      )
    });
  }
}
