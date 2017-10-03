#!/bin/bash

## TODO: ver como se usan los parametros en linux
awk  	'BEGIN {
				FS = ":";
		}
		{	equipo1 = $1;
			goles1 = $2;
			equipoGoles[ equipo1 ] += goles1; 		
			for (i = goles1 ; i > 0; i--)
			{
			        goleadores[ $(2+i) ]++;
				goleadoresEquip[ $(2+i) ] = equipo1;
			}

			equipo2 = $(3+goles1);
			goles2    =  $(4+goles1);
			equipoGoles[ equipo2 ] += goles2; 	
			for (i = goles2; i > 0; i--)
			{
 				goleadores[ $(4+goles1+i) ]++;
				goleadoresEquip[ $(4+goles1+i) ] = equipo2;
                       }

			if( goles1 > goles2 )
			{
				equipoPuntos[ equipo1 ] += 2 ;
				equipoPuntos[ equipo2 ] += 0;
			}else if( goles2 > goles1)
			{
				equipoPuntos[ equipo1 ] += 0;
				equipoPuntos[ equipo2 ] += 2;
			}else
			{
				equipoPuntos[ equipo1 ] += 1;
				equipoPuntos[ equipo2 ] += 1;
			}		

		} 
		END{
			for( goleador in goleadores )
			{
				print goleador " ; "  goleadores[ goleador ] " ; "  goleadoresEquip[ goleador ] > "goleadoresUnsorted.csv";	
			}

			for( equipo in equipoPuntos )
			{
				print equipo " ; " equipoPuntos[ equipo ] " ; "  equipoGoles[ equipo ] > "equiposUnsorted.csv";	
			}
		}' temporada2017.txt ;

##TODO: cambiar el nombre del archivo por el q tiene q ir posta
sort -t";" -nrk2 goleadoresUnsorted.csv > goleadoresSorted.csv;
sort -t";" -nrk2 equiposUnsorted.csv > equiposSorted.csv;

rm goleadoresUnsorted.csv;
rm equiposUnsorted.csv;
