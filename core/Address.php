<?php
/**
 *  This file is part of Dashboard.
 *
 *  Dashboard is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Dashboard is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dashboard.  If not, see <http://www.gnu.org/licenses/>.
 *  
 *  @license http://www.gnu.org/licenses/gpl.txt
 *  @copyright Copyright 2007-2009 Norex Core Web Development
 *  @author See CREDITS file
 *
 */

class Address extends DBRow {
		
	const GOOGLE_API_KEY = 'ABQIAAAA3l8nFImJ5iJ4F4Bwj-CqvRTVhk_FawdprkxQ7rY9h5v2o213HxSi-uaWxHyn8bn9FsaUvqDT2U3lZg';
	
	function createTable() {
		
		$cols = array(
			'id?',
			DBColumn::make('text', 'street_address', 'Street Address'),
			DBColumn::make('text', 'city', 'City'),
			DBColumn::make('text', 'postal_code', 'Postal Code'),
			DBColumn::make('select', 'state', 'Province/State', self::getStates()),
			DBColumn::make('select', 'country', 'Country', self::getCountries()),
			DBColumn::make('//latlon', 'geocode', 'GeoCode'),
			);
		return parent::createTable("address", __CLASS__, $cols);
	}
	static function make($id = null) {return parent::make($id, __CLASS__);}
	static function getAll() {
		$args = func_get_args();
		array_unshift($args, __CLASS__);
		return call_user_func_array(array('DBRow', 'getAllRows'), $args);
	}
	static function countAll() {
		$args = func_get_args();
		array_unshift($args, __CLASS__);
		return call_user_func_array(array('DBRow', 'getCountRows'), $args);
	}
	function quickformPrefix() {return 'address_';}
	
	public static function getStates() {
		$sql = 'select id, name from states order by country, name';
		$r = Database::singleton()->query_fetch_all($sql);
		$states = array();
		foreach ($r as &$state) {
			$states[$state['id']] =$state['name'];
		}
		return $states;
	}
	
	public function getStateName() {
		if (!$this->get('state'))
			return '';
		$sql = 'select name from states where id=' . $this->get('state');
		$r = Database::singleton()->query_fetch($sql);
		return $r['name'];
	}
	
	public static function getCountries() {
		$sql = 'select id, name from countries order by name';
		$r = Database::singleton()->query_fetch_all($sql);
		$countries = array();
		foreach ($r as &$country) {
			$countries[$country['id']] =$country['name'];
		}
		return $countries;
	}
	
	public function getCountryName() {
		if (!$this->get('country'))
			return '';
		$sql = 'select name from countries where id=' . $this->get('country');
		$r = Database::singleton()->query_fetch($sql);
		return $r['name'];
	}
	
	public function getAddEditForm($target = null) {
		$form = parent::getAddEditForm($target);
		
		if ($form->isProcessed()) {
			$this->doGeocode();
			$this->save();
		}
		return $form;
	}
	
	public function doGeocode() {
		$address = urlencode($this->get('street_address') . ', ' . $this->get('city') . ', ' . $this->getStateName() . ', ' . $this->getCountryName());
		$url = 'http://maps.google.com/maps/geo?q=' . $address . '&output=csv&key=' . self::GOOGLE_API_KEY;
		$ch = curl_init();

		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_HEADER,0); //Change this to a 1 to return headers
		curl_setopt($ch, CURLOPT_USERAGENT, 'KP');
		//curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

		$data = curl_exec($ch);
		curl_close($ch);

		if (strstr($data,'200')) {
			$data = explode(',',$data);
			$precision = $data[1];
			$latitude = $data[2];
			$longitude = $data[3];
			
			$this->setGeocode($latitude . ', ' . $longitude);
		} else {
			$this->setGeocode(null);
		}
	}
}
DBRow::init('Address');
?>