/**
 * Created by petrroubal on 11.06.2023.
 */

@IsTest
public class CountryLayer2Apex_Test {

    public static final String JSON_RESPONSE = '['+
            '  {'+
            '        \"name\": \"Germany\",'+
            '        \"topLevelDomain\": ['+
            '            \".de\"'+
            '        ],'+
            '        \"alpha2Code\": \"DE\",'+
            '        \"alpha3Code\": \"DEU\",'+
            '        \"callingCodes\": ['+
            '            \"49\"'+
            '        ],'+
            '        \"capital\": \"Berlin\",'+
            '        \"altSpellings\": ['+
            '            \"DE\",'+
            '            \"Federal Republic of Germany\",'+
            '            \"Bundesrepublik Deutschland\"'+
            '        ],'+
            '        \"region\": \"Europe\",'+
            '        \"subregion\": \"Western Europe\",'+
            '        \"population\": 81770900,'+
            '        \"latlng\": ['+
            '             51,'+
            '             9'+
            '        ],'+
            '         \"demonym\": \"German\",'+
            '         \"area\": 357114,'+
            '         \"gini\":  28.3,'+
            '         \"timezones\": ['+
            '             \"UTC+01:00\"'+
            '        ],'+
            '        \"borders\": ['+
            '            \"AUT\",'+
            '            \"BEL\",'+
            '            \"CZE\",'+
            '            \"DNK\",'+
            '            \"FRA\",'+
            '            \"LUX\",'+
            '            \"NLD\",'+
            '            \"POL\",'+
            '            \"CHE\"'+
            '        ],'+
            '        \"nativeName\": \"Deutschland\",'+
            '        \"numericCode\": \"276\",'+
            '        \"currencies\": ['+
            '            {'+
            '                \"code\": \"EUR\",'+
            '                \"name\": \"Euro\",'+
            '                \"symbol\": \"€\"'+
            '            }'+
            '        ],'+
            '        \"languages\": ['+
            '            {'+
            '                \"iso639_1\": \"de\",'+
            '                \"iso639_2\": \"deu\",'+
            '                \"name\": \"German\",'+
            '                \"nativeName\": \"Deutsch\"'+
            '            }'+
            '        ],'+
            '        \"translations\": {'+
            '            \"br\": \"Alemanha\",'+
            '            \"de\": \"Deutschland\",'+
            '            \"es\": \"Alemania\",'+
            '            \"fa\": \"آلمان\",'+
            '            \"fr\": \"Allemagne\",'+
            '            \"hr\": \"Njemačka\",'+
            '            \"it\": \"Germania\",'+
            '            \"ja\": \"ドイツ\",'+
            '            \"nl\": \"Duitsland\",'+
            '            \"pt\": \"Alemanha\"'+
            '        },'+
            '        \"flag\": \"https://restcountries.eu/data/deu.svg\",'+
            '        \"regionalBlocs\": ['+
            '            {'+
            '                \"acronym\": \"EU\",'+
            '                \"name\": \"European Union\"'+
            '            }'+
            '        ],'+
            '        \"cioc\": \"GER\"'+
            '    }'+
            ''+
            ']';

    @IsTest
    private static void testParse() {

        List<CountryLayer2Apex> obj = CountryLayer2Apex.parse(JSON_RESPONSE);
        System.assert(obj != null);
    }
}