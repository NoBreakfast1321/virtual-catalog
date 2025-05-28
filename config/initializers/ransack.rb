Ransack.configure do |config|
  config.custom_arrows = {
    up_arrow: '
      <span class="ml-2 size-5 inline-flex items-center justify-center rounded bg-gray-100 group-hover:bg-gray-200">
        <i class="ri-sort-asc text-gray-900"></i>
      </span>
    ',
    down_arrow: '
      <span class="ml-2 size-5 inline-flex items-center justify-center rounded bg-gray-100 group-hover:bg-gray-200">
        <i class="ri-sort-desc text-gray-900"></i>
      </span>
    ',
    default_arrow: ""
  }
end
