//
//  undergroundLines.swift
//  Timely
//
//  Created by Rishi Thiahulan on 14/02/2024.
//

import Foundation

// list of stations served by bakerloo line
let bakerloo:[String] = ["Harrow & Wealdstone", "Kenton", "South Kenton", "North Wembley", "Wembley Central", "Stonebridge Park", "Harlesden", "Willesden Junction", "Kensal Green", "Queen's Park", "Kilburn Park", "Maida Vale", "Warwick Avenue", "Paddington", "Edgeware Road", "Marylebone", "Baker Street", "Regent's Park", "Oxford Circus", "Piccadilly Circus", "Charing Cross", "Embankment", "Waterloo", "Lambeth North", "Elephant & Castle"]


let central:[String] = ["West Ruislip", "Ruislip Gardens", "South Ruislip", "Northolt", "Greenford", "Perivale", "Hanger Lane", "West Acton", "Ealing Broadway", "North Acton", "East Acton", "White City", "Shepherd's Bush", "Holland Park", "Notting Hill Gate", "Queensway", "Lancaster Gate", "Marble Arch", "Bond Street", "Oxford Circus", "Tottenham Court Road", "Holborn", "Chancery Lane", "St. Paul's", "Bank", "Liverpool Street", "Bethnal Green", "Mile End", "Stratford", "Leyton", "Leytonstone", "Wanstead", "Redbridge", "Gants Hill", "Newbury Park", "Barkingside", "Fairlop", "Hainault", "Grange Hill", "Chigwell", "Roding Valley", "Snaresbrook", "South Woodford", "Woodford", "Buckhurst Hill", "Loughton", "Debden", "Theyton Bois", "Epping"]

let circle:[String] = ["Hammersmith", "Goldhawk Road", "Shepherd's Bush Market", "Wood Lane", "Latimer Road", "Ladbroke Grove", "Westbourne Park", "Royal Oak", "Paddington", "Edgware Road", "Baker Street", "Great Portland Street", "Euston Square", "King's Cross St. Pancras", "Farringdon", "Barbican", "Moorgate", "Liverpool Street", "Aldgate", "Tower Hill", "Monument", "Cannon Street", "Mansion House", "Blackfriars", "Temple", "Embankment", "Westminster", "St. James's Park", "Victoria", "Sloane Square", "South Kensington", "Gloucester Road", "High Street Kensington", "Notting Hill Gate", "Bayswater"]

let district:[String] = ["Ealing Broadway", "Ealing Common", "Acton Town", "Chiswick Park", "Richmond", "Kew Gardens", "Gunnersbury", "Turnham Green", "Stamford Brook", "Ravenscourt Park", "Hammersmith", "Barons Court", "West Kensington", "Kensington (Olympia)", "West Brompton", "Fulham Broadway", "Parsons Green", "Putney Bridge", "East Putney", "Southfields", "Wimbledon Park", "Wimbledon", "Earl's Court", "High Street Kensington", "Notting Hill Gate", "Bayswater", "Paddington", "Edgware Road", "Gloucester Road", "South Kensington", "Sloane Square", "Victoria", "St. James's Park", "Westminster", "Embankment", "Temple", "Blackfriars", "Mansion House", "Cannon Street", "Monument", "Tower Hill", "Aldgate East", "Whitechapel", "Stepney Green", "Mile End", "Bow Road", "Bromley-By-Bow", "West Ham", "Plaistow", "Upton Park", "East Ham", "Barking", "Upney", "Becontree", "Dagenham Heathway", "Dagenham East", "Elm Park", "Hornchurch", "Upminster Bridge", "Upminster"]

let hammersmithcity:[String] = ["Hammersmith", "Goldhawk Road", "Shepherd's Bush Market", "Wood Lane", "Latimer Road", "Ladbroke Grove", "Westbourne Park", "Royal Oak", "Paddington", "Edgware Road", "Baker Street", "Great Portland Street", "Euston Square", "King's Cross St. Pancras", "Farringdon", "Barbican", "Moorgate", "Liverpool Street", "Aldgate East", "Whitechapel", "Stepney Green", "Mile End", "Bow Road", "Bromley-By-Row", "West Ham", "Plaistow", "Upton Park", "East Ham", "Barking"]

let jubilee:[String] = ["Stanmore", "Canons Park", "Queensbury", "Kingsbury", "Wembley Park", "Neasden", "Dollis Hill", "Willesden Green", "Kilburn", "West Hampstead", "Finchley Road", "Swiss Cottage", "St. John's Wood", "Baker Street", "Bond Street", "Green Park", "Westminster", "Waterloo", "Southwark", "London Bridge", "Bermondsey", "Canada Water", "Canary Wharf", "North Greenwich", "Canning Town", "West Ham", "Stratford"]

let metropolitan:[String] = ["Chesham", "Amersham", "Chalfont & Latimer", "Chorleywood", "Rickmansworth", "Croxley", "Watford", "Moor Park", "Northwood", "Northwood Hills", "Pinner", "North Harrow", "Uxbridge", "Hillingdon", "Ickenham", "Ruislip", "Ruislip Manor", "Eastcote", "Rayners Lane", "West Harrow", "Harrow-on-the-Hill", "Northwick Park", "Preston Road", "Wembley Park", "Finchley Road", "Baker Street", "Great Portland Street", "Euston Square", "King's Cross St. Pancras", "Farringdon", "Barbican", "Moorgate", "Liverpool Street", "Aldgate"]

let northern:[String] = ["High Barnet", "Totteridge & Whetstone", "Woodside Park", "West Finchley", "Mill Hill East", "Finchley Central", "East Finchley", "Highgate", "Archway", "Tufnell Park", "Kentish Town", "Edgware", "Burnt Oak", "Colindale", "Hendon Central", "Brent Cross", "Golders Green", "Hampstead", "Belsize Park", "Chalk Farm", "Camden Town", "Mornington Crescent", "Euston", "King's Cross St. Pancras", "Angel", "Old Street", "Moorgate", "Bank", "London Bridge", "Borough", "Elephant & Castle", "Kennington", "Warren Street", "Goodge Street", "Tottenham Court Road", "Leicester Square", "Charing Cross", "Embankment", "Waterloo", "Nine Elms", "Battersea Power Station", "Oval", "Stockwell", "Clapham Common", "Clapham North", "Clapham South", "Balham", "Tooting Bec", "Tooting Broadway", "Colliers Wood", "South Wimbledon", "Morden"]

let piccadilly:[String] = ["Uxbridge", "Hillingdon", "Ickenham", "Ruislip", "Ruislip Manor", "Eastcote", "Rayners Lane", "South Harrow", "Sudbury Hill", "Sudbury Town", "Alperton", "Park Royal", "North Ealing", "Ealing Common", "Heathrow Terminal 5", "Heathrow Terminals 2 & 3", "Heathrow Terminal 4", "Hatton Cross", "Hounslow West", "Hounslow Central", "Hounslow East", "Osterley", "Boston Manor", "Northfields", "South Ealing", "Acton Town", "Turnham Green", "Hammersmith", "Barons Court", "Earl's Court", "Gloucester Road", "South Kensington", "Knightsbridge", "Hyde Park Corner", "Green Park", "Piccadilly Circus", "Leicester Square", "Covent Garden", "Holborn", "Russell Square", "King's Cross St. Pancras", "Caledonian Road", "Holloway Road", "Arsenal", "Finsbury Park", "Manor House", "Turnpike Lane", "Wood Green", "Bounds Green", "Arnos Grove", "Southgate", "Oakwood", "Cockfosters"]

let victoria:[String] = ["Walthamstown Central", "Blackhorse Road", "Tottenham Hale", "Seven Sisters", "Finsbury Park", "Highbury & Islington", "King's Cross St. Pancras", "Euston", "Warren Street", "Oxford Circus", "Green Park", "Victoria", "Pimlico", "Vauxhall", "Stockwell", "Brixton"]

let waterloo:[String] = ["Waterloo", "Bank"]

let elizabeth:[String] = ["Reading", "Twyford", "Maidenhead", "Taplow", "Burnham", "Slough", "Langley", "Iver", "West Drayton", "Heathrow Terminal 5", "Heathrow Terminal 4", "Heathrow Central", "Hayes & Harlington", "Southall", "Hanwell", "West Ealing", "Ealing Broadway", "Acton Main Line", "Old Oak Common", "Paddington", "Bond Street", "Tottenham Court Road", "Farringdon", "Liverpool Street", "Whitechapel", "Canary Wharf", "Custom House", "Woolwich", "Abbey Wood", "Stratford", "Maryland", "Forest Gate", "Manor Park", "Ilford", "Seven Kings", "Goodmayes", "Chadwell Heath", "Romford", "Gidea Park", "Harold Wood", "Brentwood", "Shenfield"]