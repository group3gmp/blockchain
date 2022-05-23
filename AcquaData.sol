//made by group 3 - XLRI ExPGDM

pragma solidity ^0.4.6;

contract AquaData {
// -- General Product Structure --
struct Product{
    uint32 lotId;
    string fishType;
    string weight;
    string FishData;
}

Product[] products;
struct ProductLot{
    uint32 lotNumber;
    uint32 idValueChainOwner;
    uint32 idProduct;
    string unit;
    uint32 amount; 
    string lotCreationDate;
    uint32[] lotEventIDs;
}

ProductLot[] productLots;
struct ValueChainOwner{
    uint32 id;
    string name;
    string addressLocation;
    string phone;
    string email;
    OperType operType;
}
enum OperType{
    ShipOwner,
    AquacultureFarm,
    Logistics,
    Industry,
    Retailer
}
// -- Events in the Value Chain --
struct Event{
uint32 idEvent;// 0-Capture, 1-Production, 2-Transformation, 3-Transport, 4-Storage,
uint16 eventType;// 5-Sale,6-QualityAssessment, 7-Final purchase
}

struct CaptureEvent{
    uint32 idEvent;
    string description;
    string geographicZone;
    uint32 latitude;
    uint32 longitude;
    string unit;
    uint32 amount;
    uint32 idValueChainOwner;
    string eventDate;
    uint32 vesselId;
    uint32 newLotNumber; //New Lot number
}

mapping(uint32 => Event) private events;
uint32 private eventsCount;

mapping(uint32 => CaptureEvent) public captureEvents;
//Simllar events at every stage of vlue chain
/*mapping(uint32 => AquacultureProdEvent) public productionEvents;
mapping(uint32 => SaleEvent) public saleEvents;
mapping(uint32 => TransportEvent) public transportEvents;
mapping(uint32 => StorageEvent) public storageEvents;
mapping(uint32 => TransformationEvent) public transformationEvents;
mapping(uint32 => QualityAssessmentEvent) public assessmentEvents;
mapping(uint32 => finalEvent) public finalEvents;*/

// Create Fish capture event

function createFishCaptureEvent(string memory _description, string memory _geographicZone, uint32 _latitude, uint32 _longitude,
uint32 _vesselId, uint32 _idValueChainOwner, uint32 _idProduct, uint32 _lotNumber, string memory _unit, 
uint32 _amount, string memory _eventDate) 
public 
    {
    if( products[_idProduct].lotId == 0) revert("Product does not exist!");
    eventsCount++;
    events[eventsCount] = Event(eventsCount, 0);
    productLots[_lotNumber] = ProductLot(_lotNumber, _idValueChainOwner,_idProduct, _unit, _amount, _eventDate, new uint32[](0));
    productLots[_lotNumber].lotEventIDs.push(eventsCount);
    captureEvents[eventsCount] = CaptureEvent(eventsCount, _description, _geographicZone, _latitude, _longitude, _unit, _amount, _idValueChainOwner, _eventDate, _vesselId, _lotNumber);
    }

}
