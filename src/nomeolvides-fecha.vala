/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/*
 * nomeolvides-fecha.vala
 * Copyright (C) 2016 Fernando Fernandez <fernando@softwareperonista.com.ar>
 *
 * nomeolvides is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * nomeolvides is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using GLib;

public class Nomeolvides.Fecha : GLib.Object {
	private DateTime dia_mes;
    private int anio;
    private int siglo;
    private Presicion presicion;

	public Fecha ( string fecha, Presicion presicion ) {
		this.presicion = presicion;
		switch (presicion) {
			case Presicion.DIA:
			case Presicion.MES:
				this.set_dia_mes ( fecha );
				break;
			case Presicion.ANIO:
				this.set_anio ( fecha );
				break;
			case Presicion.SIGLO:
				this.set_siglo ( fecha );
				break;

		}
	}

	private void set_dia_mes ( string fecha ) {
		int dia;
		string[] fecha_separada;

		fecha_separada = fecha.split ( "-" );

		if ( fecha_separada.length == 2 ) {
			dia = 1;
		} else {
			dia = int.parse( fecha_separada [2] );
		}

		this.dia_mes = new DateTime.utc ( int.parse( fecha_separada[0] ),
		                                  int.parse( fecha_separada[1] ),
		                                  dia, 0, 0, 0 );
	}

	private void set_anio ( string fecha ) {

		this.anio = int.parse ( fecha );
	}

	private void set_siglo ( string fecha ) {

		this.siglo = int.parse ( fecha );
	}

	public string get_dia () {
		string dia = "";

		if ( this.presicion == Presicion.DIA ) {
			dia = this.dia_mes.get_day_of_month ().to_string();
		}

		return dia;
	}

	public string get_mes () {
		string mes = "";

		if ( this.presicion < Presicion.ANIO ) {
			mes = this.dia_mes.format ("%B");
		}

		return mes;
	}

	public string get_mes_numerico () {
		string mes = "";

		if ( this.presicion < Presicion.ANIO ) {
			mes = this.dia_mes.get_month ().to_string();
		}

		return mes;
	}

	public string get_anio () {
		string anio = "";

		if ( this.presicion < Presicion.ANIO ) {
			anio = this.dia_mes.get_year ().to_string();
		} else {
			if ( this.presicion == Presicion.ANIO ) {
				anio = this.anio.to_string();
			}
		}

		return anio;
	}

	public string get_siglo () {
		string siglo = "";

		if ( this.presicion < Presicion.SIGLO ) {
			siglo = a_romanos ( (int.parse ( this.get_anio () ) / 100)   + 1);
		} else {
			siglo = a_romanos ( this.siglo );
		}

		return siglo;
	}

	public string get_fecha_format ( string formato ) {
		string retorno;

		retorno = formato.replace ( "%B", this.get_mes() );
		retorno = retorno.replace ( "%e", this.get_dia() );
		retorno = retorno.replace ( "%Y", this.get_anio() );

		return retorno;
	}

	public static string a_romanos ( int decimal ) {
		int a,i;

		var romano = new StringBuilder ();

		if ( decimal >= 1000 )
		{
			a = decimal / 1000;
			for ( i = 0; i < a; i++ ) {
				romano.append ( "M" );
			}
			decimal = decimal - ( a * 1000 );
		}

		if ( decimal >= 900 ) {
			romano.append ( "CM" );
			decimal = decimal - 900;
		} else {
			if ( decimal >= 500 ) {
				romano.append ( "D" );
				decimal = decimal - 500;
			} else {
				if ( decimal >= 400 ) {
					romano.append ( "CD" );
					decimal = decimal - 400;
				}
			}
			if ( decimal >= 100 ) {
				a = decimal / 100;
				for ( i = 0; i < a; i++ ) {
					romano.append ( "C" );
				}
				decimal = decimal - ( a * 100 );
			}
		}

		if ( decimal >= 90 ) {
			romano.append ( "XC" );
			decimal = decimal - 90;
		} else {
			if ( decimal >= 50 ) {
				romano.append ( "L" );
				decimal = decimal - 50;
			} else {
				if ( decimal >= 40 ) {
					romano.append ( "XL" );
					decimal = decimal - 40;
				}
			}
			if ( decimal >= 10 ) {
				a = decimal / 10;
				for ( i = 0; i < a; i++ ) {
					romano.append ( "X" );
				}
				decimal = decimal - ( a * 10 );
			}
		}

		if ( decimal >= 9 ) {
			romano.append ( "IX" );
			decimal = decimal - 9;
		} else {
			if ( decimal >= 5 ) {
				romano.append ( "V" );
				decimal = decimal - 5;
			} else {
				if ( decimal >= 4 ) {
					romano.append ( "IV" );
					decimal = decimal - 4;
				}
			}
			if ( decimal >= 1 ) {
				for ( i = 0; i < decimal; i++ ) {
					romano.append ( "I" );
				}
				decimal = 0;
			}
		}

		return romano.str;
	}

	public enum Presicion { DIA, MES, ANIO, SIGLO }
}
