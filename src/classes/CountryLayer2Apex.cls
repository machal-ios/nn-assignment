/**
 * Created by petrroubal on 11.06.2023.
 */

public with sharing class CountryLayer2Apex{

    public class Languages {
        public String iso639_1;
        public String iso639_2;
        public String name;
        public String nativeName;
    }

    public String name;
    public List<String> topLevelDomain;
    public String alpha2Code;
    public String alpha3Code;
    public List<String> callingCodes;
    public String capital;
    public List<String> altSpellings;
    public String region;
    public String subregion;
    public Integer population;
    public List<Integer> latlng;
    public String demonym;
    public Integer area;
    public Double gini;
    public List<String> timezones;
    public List<String> borders;
    public String nativeName;
    public String numericCode;
    public List<Currencies> currencies;
    public List<Languages> languages;
    public Translations translations;
    public String flag;
    public List<RegionalBlocs> regionalBlocs;
    public String cioc;

    public class Translations {
        public String br;
        public String de;
        public String es;
        public String fa;
        public String fr;
        public String hr;
        public String it;
        public String ja;
        public String nl;
        public String pt;
    }

    public class RegionalBlocs {
        public String acronym;
        public String name;
    }

    public class Currencies {
        public String code;
        public String name;
        public String symbol;
    }


    public static List<CountryLayer2Apex> parse(String json) {
        return (List<CountryLayer2Apex>) System.JSON.deserialize(json, List<CountryLayer2Apex>.class);
    }

}