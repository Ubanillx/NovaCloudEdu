import React, { useState, useEffect, useMemo } from 'react';
import { MapPin, ChevronDown } from 'lucide-react';
import provincesData from 'china-division/dist/provinces.json';
import citiesData from 'china-division/dist/cities.json';
import areasData from 'china-division/dist/areas.json';

interface Province { code: string; name: string }
interface City { code: string; name: string; provinceCode: string }
interface Area { code: string; name: string; cityCode: string; provinceCode: string }

const provinces = provincesData as Province[];
const cities = citiesData as City[];
const areas = areasData as Area[];

interface RegionPickerProps {
  value: string;
  onChange: (value: string) => void;
}

const selectCls = 'w-full px-3 py-2 rounded-lg border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 transition-all appearance-none cursor-pointer';

/**
 * 省市区三级联动选择器
 * value 格式: "省 市 区" (空格分隔)
 */
const RegionPicker: React.FC<RegionPickerProps> = ({ value, onChange }) => {
  const [provinceCode, setProvinceCode] = useState('');
  const [cityCode, setCityCode] = useState('');
  const [areaCode, setAreaCode] = useState('');

  // 根据传入的 value 反解析省市区代码
  useEffect(() => {
    if (!value) {
      setProvinceCode('');
      setCityCode('');
      setAreaCode('');
      return;
    }
    const parts = value.split(' ').filter(Boolean);
    if (parts.length >= 1) {
      const p = provinces.find(item => item.name === parts[0]);
      if (p) {
        setProvinceCode(p.code);
        if (parts.length >= 2) {
          const c = cities.find(item => item.provinceCode === p.code && item.name === parts[1]);
          if (c) {
            setCityCode(c.code);
            if (parts.length >= 3) {
              const a = areas.find(item => item.cityCode === c.code && item.name === parts[2]);
              if (a) setAreaCode(a.code);
            }
          }
        }
      }
    }
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const filteredCities = useMemo(() => {
    if (!provinceCode) return [];
    return cities.filter(c => c.provinceCode === provinceCode);
  }, [provinceCode]);

  const filteredAreas = useMemo(() => {
    if (!cityCode) return [];
    return areas.filter(a => a.cityCode === cityCode);
  }, [cityCode]);

  const buildValue = (pCode: string, cCode: string, aCode: string) => {
    const parts: string[] = [];
    const p = provinces.find(item => item.code === pCode);
    if (p) parts.push(p.name);
    const c = cities.find(item => item.code === cCode);
    if (c) parts.push(c.name);
    const a = areas.find(item => item.code === aCode);
    if (a) parts.push(a.name);
    return parts.join(' ');
  };

  const handleProvinceChange = (code: string) => {
    setProvinceCode(code);
    setCityCode('');
    setAreaCode('');
    onChange(buildValue(code, '', ''));
  };

  const handleCityChange = (code: string) => {
    setCityCode(code);
    setAreaCode('');
    onChange(buildValue(provinceCode, code, ''));
  };

  const handleAreaChange = (code: string) => {
    setAreaCode(code);
    onChange(buildValue(provinceCode, cityCode, code));
  };

  return (
    <div>
      <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">
        <span className="inline-flex items-center gap-1"><MapPin size={12} /> 地址</span>
      </label>
      <div className="grid grid-cols-3 gap-2">
        {/* 省 */}
        <div className="relative">
          <select
            value={provinceCode}
            onChange={e => handleProvinceChange(e.target.value)}
            className={selectCls}
          >
            <option value="">选择省份</option>
            {provinces.map(p => (
              <option key={p.code} value={p.code}>{p.name}</option>
            ))}
          </select>
          <ChevronDown size={14} className="absolute right-2.5 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none" />
        </div>
        {/* 市 */}
        <div className="relative">
          <select
            value={cityCode}
            onChange={e => handleCityChange(e.target.value)}
            className={selectCls}
            disabled={!provinceCode}
          >
            <option value="">选择城市</option>
            {filteredCities.map(c => (
              <option key={c.code} value={c.code}>{c.name}</option>
            ))}
          </select>
          <ChevronDown size={14} className="absolute right-2.5 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none" />
        </div>
        {/* 区 */}
        <div className="relative">
          <select
            value={areaCode}
            onChange={e => handleAreaChange(e.target.value)}
            className={selectCls}
            disabled={!cityCode}
          >
            <option value="">选择地区</option>
            {filteredAreas.map(a => (
              <option key={a.code} value={a.code}>{a.name}</option>
            ))}
          </select>
          <ChevronDown size={14} className="absolute right-2.5 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none" />
        </div>
      </div>
    </div>
  );
};

export default RegionPicker;
