import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Supported locales in display order.
const supportedLocales = [
  Locale('en'),
  Locale('zh'),
  Locale('hi'),
  Locale('es'),
  Locale('fr'),
];

/// Flag emoji + language label for each locale.
const localeFlags = {
  'en': ('🇬🇧', 'EN'),
  'zh': ('🇨🇳', 'ZH'),
  'hi': ('🇮🇳', 'HI'),
  'es': ('🇪🇸', 'ES'),
  'fr': ('🇫🇷', 'FR'),
};

class AppStrings {
  final String _lc; // language code
  AppStrings(this._lc);

  static AppStrings of(BuildContext context) =>
      Localizations.of<AppStrings>(context, AppStrings) ?? AppStrings('en');

  String _t(String key) =>
      _data[_lc]?[key] ?? _data['en']![key]!;

  // ── Sliders ──────────────────────────────────────────────
  String get monthlySpend   => _t('monthlySpend');
  String get co2Awareness   => _t('co2Awareness');
  String get awarenessHint  => _t('awarenessHint');
  String get veryLow        => _t('veryLow');
  String get low            => _t('low');
  String get average        => _t('average');
  String get high           => _t('high');
  String get veryHigh       => _t('veryHigh');

  // ── Result display ────────────────────────────────────────
  String get tCO2Year       => _t('tCO2Year');
  String get accuracyRange  => _t('accuracyRange');
  String get belowTarget    => _t('belowTarget');
  String aboveTarget(String times) =>
      _t('aboveTarget').replaceFirst('{x}', times);

  // ── Benchmark bar ─────────────────────────────────────────
  String get compare        => _t('compare');
  String get fairShare      => _t('fairShare');
  String get africaAvg      => _t('africaAvg');
  String get sAmericaAvg    => _t('sAmericaAvg');
  String get asiaAvg        => _t('asiaAvg');
  String get worldAvg       => _t('worldAvg');
  String get euAvg          => _t('euAvg');
  String get oceaniaAvg     => _t('oceaniaAvg');
  String get nAmericaAvg    => _t('nAmericaAvg');

  // ── About screen ──────────────────────────────────────────
  String get appTitle           => _t('appTitle');
  String get version            => _t('version');
  String get privacyHeading     => _t('privacyHeading');
  String get privacyText        => _t('privacyText');
  String get formulaHeading     => _t('formulaHeading');
  String get formulaText        => _t('formulaText');
  String get accuracyHeading    => _t('accuracyHeading');
  String get accuracyText       => _t('accuracyText');
  String get referencesHeading  => _t('referencesHeading');

  // ── Shared ────────────────────────────────────────────────
  String get yours => _t('yours');
}

// ─────────────────────────────────────────────────────────────
// Delegate
// ─────────────────────────────────────────────────────────────

class AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const AppStringsDelegate();

  @override
  bool isSupported(Locale locale) =>
      supportedLocales.any((l) => l.languageCode == locale.languageCode);

  @override
  Future<AppStrings> load(Locale locale) =>
      SynchronousFuture(AppStrings(locale.languageCode));

  @override
  bool shouldReload(AppStringsDelegate old) => false;
}

// ─────────────────────────────────────────────────────────────
// Translations
// ─────────────────────────────────────────────────────────────

const _data = <String, Map<String, String>>{
  // ── English ───────────────────────────────────────────────
  'en': {
    'monthlySpend':   'Monthly spend',
    'co2Awareness':   'CO₂ awareness',
    'awarenessHint':  'Less meat · less flying · public transport · less consumption',
    'veryLow':        'Very low',
    'low':            'Low',
    'average':        'Average',
    'high':           'High',
    'veryHigh':       'Very high',
    'tCO2Year':       't CO₂e / year',
    'accuracyRange':  '±30% estimation range',
    'belowTarget':    'Below 1.5°C fair share 🌱',
    'aboveTarget':    '{x}× the 1.5°C fair share (2.5t)',
    'compare':        'Compare',
    'fairShare':      '1.5°C fair share',
    'africaAvg':      'Africa avg',
    'sAmericaAvg':    'S. America avg',
    'asiaAvg':        'Asia avg',
    'worldAvg':       'World avg',
    'euAvg':          'EU avg',
    'oceaniaAvg':     'Oceania avg',
    'nAmericaAvg':    'N. America avg',
    'appTitle':       'Co2 Footprint Easy',
    'version':        'v1.0  ·  NoTrackApps',
    'privacyHeading': 'Privacy',
    'privacyText':    'No internet connection. No data stored. No permissions required.',
    'formulaHeading': 'Formula',
    'formulaText':    'CO₂e (t/yr) = monthly spend × 12 × awareness factor × 0.0007\n\n'
                      'The 0.0007 constant is the EU average consumption-based emission '
                      'intensity (0.7 kg CO₂e / €1), covering all greenhouse gases '
                      'across the full supply chain.',
    'accuracyHeading':'Accuracy & limitations',
    'accuracyText':   'This is an order-of-magnitude estimator (±30%). Intensity varies '
                      'by spending category and rises with income. Comparison benchmarks '
                      'are territorial CO₂ per capita (GCP, 2023) — CO₂ only, not full '
                      'CO₂e — so your result will read somewhat higher than the bars. '
                      'The awareness factor is an illustrative model construct, not a '
                      'published constant.',
    'referencesHeading': 'References',
    'yours':          'NoTrackApps',
  },

  // ── Mandarin Chinese ──────────────────────────────────────
  'zh': {
    'monthlySpend':   '月支出',
    'co2Awareness':   '碳意识',
    'awarenessHint':  '少吃肉 · 少乘飞机 · 公共交通 · 减少消费',
    'veryLow':        '非常低',
    'low':            '低',
    'average':        '一般',
    'high':           '高',
    'veryHigh':       '非常高',
    'tCO2Year':       '吨 CO₂e / 年',
    'accuracyRange':  '±30% 估算范围',
    'belowTarget':    '低于1.5°C公平份额 🌱',
    'aboveTarget':    '{x}× 1.5°C公平份额（2.5吨）',
    'compare':        '对比',
    'fairShare':      '1.5°C公平份额',
    'africaAvg':      '非洲均值',
    'sAmericaAvg':    '南美均值',
    'asiaAvg':        '亚洲均值',
    'worldAvg':       '全球均值',
    'euAvg':          '欧盟均值',
    'oceaniaAvg':     '大洋洲均值',
    'nAmericaAvg':    '北美均值',
    'appTitle':       'Co2 Footprint Easy',
    'version':        'v1.0  ·  NoTrackApps',
    'privacyHeading': '隐私',
    'privacyText':    '无网络连接，不存储数据，无需任何权限。',
    'formulaHeading': '计算公式',
    'formulaText':    'CO₂e（吨/年）= 月支出 × 12 × 碳意识系数 × 0.0007\n\n'
                      '0.0007 为欧盟家庭支出的平均碳排放强度（每欧元0.7千克CO₂e），'
                      '涵盖全供应链所有温室气体。',
    'accuracyHeading':'准确性与局限性',
    'accuracyText':   '本工具为数量级估算（±30%）。排放强度因消费类别和收入水平而异。'
                      '对比基准为各地区领土CO₂人均排放（仅CO₂，非CO₂e），'
                      '因此您的结果可能高于参考值。碳意识系数为模型构建值，非文献发表常数。',
    'referencesHeading': '参考文献',
    'yours':          'NoTrackApps',
  },

  // ── Hindi ─────────────────────────────────────────────────
  'hi': {
    'monthlySpend':   'मासिक खर्च',
    'co2Awareness':   'CO₂ जागरूकता',
    'awarenessHint':  'कम मांस · कम उड़ान · सार्वजनिक परिवहन · कम उपभोग',
    'veryLow':        'बहुत कम',
    'low':            'कम',
    'average':        'औसत',
    'high':           'अधिक',
    'veryHigh':       'बहुत अधिक',
    'tCO2Year':       'टन CO₂e / वर्ष',
    'accuracyRange':  '±30% अनुमान सीमा',
    'belowTarget':    '1.5°C उचित सीमा से नीचे 🌱',
    'aboveTarget':    '{x}× 1.5°C उचित सीमा (2.5 टन)',
    'compare':        'तुलना करें',
    'fairShare':      '1.5°C उचित सीमा',
    'africaAvg':      'अफ्रीका औसत',
    'sAmericaAvg':    'दक्षिण अमेरिका औसत',
    'asiaAvg':        'एशिया औसत',
    'worldAvg':       'विश्व औसत',
    'euAvg':          'EU औसत',
    'oceaniaAvg':     'ओशिनिया औसत',
    'nAmericaAvg':    'उत्तर अमेरिका औसत',
    'appTitle':       'Co2 Footprint Easy',
    'version':        'v1.0  ·  NoTrackApps',
    'privacyHeading': 'गोपनीयता',
    'privacyText':    'कोई इंटरनेट कनेक्शन नहीं। कोई डेटा संग्रहीत नहीं। कोई अनुमति आवश्यक नहीं।',
    'formulaHeading': 'सूत्र',
    'formulaText':    'CO₂e (टन/वर्ष) = मासिक खर्च × 12 × जागरूकता कारक × 0.0007\n\n'
                      '0.0007 EU का औसत उपभोग-आधारित उत्सर्जन तीव्रता है '
                      '(€1 पर 0.7 किग्रा CO₂e), जो सम्पूर्ण आपूर्ति श्रृंखला के '
                      'सभी ग्रीनहाउस गैसों को कवर करता है।',
    'accuracyHeading':'सटीकता और सीमाएं',
    'accuracyText':   'यह एक परिमाण-क्रम अनुमानक है (±30%)। उत्सर्जन तीव्रता व्यय '
                      'श्रेणी और आय के अनुसार भिन्न होती है। तुलना बेंचमार्क क्षेत्रीय '
                      'CO₂ प्रति व्यक्ति हैं (केवल CO₂, CO₂e नहीं), इसलिए आपका '
                      'परिणाम बार से कुछ अधिक हो सकता है।',
    'referencesHeading': 'संदर्भ',
    'yours':          'NoTrackApps',
  },

  // ── Spanish ───────────────────────────────────────────────
  'es': {
    'monthlySpend':   'Gasto mensual',
    'co2Awareness':   'Conciencia CO₂',
    'awarenessHint':  'Menos carne · menos vuelos · transporte público · menos consumo',
    'veryLow':        'Muy baja',
    'low':            'Baja',
    'average':        'Media',
    'high':           'Alta',
    'veryHigh':       'Muy alta',
    'tCO2Year':       't CO₂e / año',
    'accuracyRange':  '±30% rango estimado',
    'belowTarget':    'Por debajo del objetivo 1,5°C 🌱',
    'aboveTarget':    '{x}× el objetivo 1,5°C (2,5 t)',
    'compare':        'Comparar',
    'fairShare':      'Objetivo 1,5°C',
    'africaAvg':      'Media África',
    'sAmericaAvg':    'Media S. América',
    'asiaAvg':        'Media Asia',
    'worldAvg':       'Media mundial',
    'euAvg':          'Media UE',
    'oceaniaAvg':     'Media Oceanía',
    'nAmericaAvg':    'Media N. América',
    'appTitle':       'Co2 Footprint Easy',
    'version':        'v1.0  ·  NoTrackApps',
    'privacyHeading': 'Privacidad',
    'privacyText':    'Sin conexión a internet. Sin datos almacenados. Sin permisos requeridos.',
    'formulaHeading': 'Fórmula',
    'formulaText':    'CO₂e (t/año) = gasto mensual × 12 × factor de conciencia × 0,0007\n\n'
                      'La constante 0,0007 es la intensidad de emisión media de la UE '
                      '(0,7 kg CO₂e / €1), abarcando todos los gases de efecto invernadero '
                      'a lo largo de la cadena de suministro.',
    'accuracyHeading':'Precisión y limitaciones',
    'accuracyText':   'Es una estimación de orden de magnitud (±30%). La intensidad varía '
                      'según la categoría de gasto y aumenta con los ingresos. Los puntos '
                      'de referencia son CO₂ territorial per cápita (solo CO₂, no CO₂e), '
                      'por lo que tu resultado puede ser algo mayor que las barras.',
    'referencesHeading': 'Referencias',
    'yours':          'NoTrackApps',
  },

  // ── French ────────────────────────────────────────────────
  'fr': {
    'monthlySpend':   'Dépenses mensuelles',
    'co2Awareness':   'Conscience CO₂',
    'awarenessHint':  'Moins de viande · moins de vols · transports en commun · moins de consommation',
    'veryLow':        'Très faible',
    'low':            'Faible',
    'average':        'Moyenne',
    'high':           'Élevée',
    'veryHigh':       'Très élevée',
    'tCO2Year':       't CO₂e / an',
    'accuracyRange':  '±30% plage d\'estimation',
    'belowTarget':    'En dessous de l\'objectif 1,5°C 🌱',
    'aboveTarget':    '{x}× l\'objectif 1,5°C (2,5 t)',
    'compare':        'Comparer',
    'fairShare':      'Objectif 1,5°C',
    'africaAvg':      'Moy. Afrique',
    'sAmericaAvg':    'Moy. Amér. du Sud',
    'asiaAvg':        'Moy. Asie',
    'worldAvg':       'Moy. mondiale',
    'euAvg':          'Moy. UE',
    'oceaniaAvg':     'Moy. Océanie',
    'nAmericaAvg':    'Moy. Amér. du Nord',
    'appTitle':       'Co2 Footprint Easy',
    'version':        'v1.0  ·  NoTrackApps',
    'privacyHeading': 'Confidentialité',
    'privacyText':    'Pas de connexion internet. Aucune donnée stockée. Aucune permission requise.',
    'formulaHeading': 'Formule',
    'formulaText':    'CO₂e (t/an) = dépenses mensuelles × 12 × facteur de conscience × 0,0007\n\n'
                      'La constante 0,0007 est l\'intensité d\'émission moyenne de l\'UE '
                      '(0,7 kg CO₂e / €1), couvrant tous les gaz à effet de serre '
                      'sur l\'ensemble de la chaîne d\'approvisionnement.',
    'accuracyHeading':'Précision et limites',
    'accuracyText':   'Il s\'agit d\'un estimateur en ordre de grandeur (±30%). L\'intensité '
                      'varie selon la catégorie de dépense et augmente avec le revenu. '
                      'Les références sont des données de CO₂ territorial par habitant '
                      '(CO₂ uniquement, pas CO₂e), donc votre résultat peut être '
                      'légèrement supérieur aux barres.',
    'referencesHeading': 'Références',
    'yours':          'NoTrackApps',
  },
};
