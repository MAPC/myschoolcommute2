module ApplicationHelper
  def alternate_locales
    [
      { code: 'en', verbose: 'English'},
      { code: 'es', verbose: 'Spanish'},
      { code: 'pt', verbose: 'Portuguese'},
      { code: 'fr', verbose: 'French'},
      { code: 'ht', verbose: 'Haitian Creole'},
      { code: 'vi', verbose: 'Vietnamese'},
      { code: 'km', verbose: 'Khmer'},
      { code: 'zh', verbose: 'Chinese'},
      { code: 'ar', verbose: 'Arabic'}
    ]
  end
end
