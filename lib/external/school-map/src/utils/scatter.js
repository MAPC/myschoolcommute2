export default function scatter(_points, radius = .00005) {
  const points = [..._points];
  const locations = {};

  points.forEach(point => {
    const [ lat, lng ] = point.geometry.coordinates;
    const location = `${lat}-${lng}`;

    locations[location] = locations[location] || [];
    locations[location].push(point);
  });

  // Displace these locations by a small amount so they don't entirely overlap
  Object.values(locations)
    .filter(location => location.length > 1)
    .forEach(location => {
      location.forEach((point, i) => {
        const [ lat, lng ] = point.geometry.coordinates;

        const radian = i * (Math.PI / ((location.length - 1) / 2));
        const adjustedLat = lat + (Math.sin(radian) * radius);
        const adjustedLng = lng + (Math.cos(radian) * radius);

        point.geometry.coordinates = [ adjustedLat, adjustedLng ];
      });
    });

  return points;
}
