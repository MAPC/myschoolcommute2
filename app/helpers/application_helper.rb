module ApplicationHelper
  def alternate_locales
    [
      { code: 'en', verbose: 'English'},
      { code: 'es', verbose: 'español'},
      { code: 'pt', verbose: 'português'},
      { code: 'fr', verbose: 'français'},
      { code: 'ht', verbose: 'Haitian Creole'},
      { code: 'vi', verbose: 'Việt'},
      { code: 'km', verbose: 'Khmer'},
      { code: 'zh', verbose: '中国的'},
      { code: 'ar', verbose: 'العربية'}
    ]
  end
end
